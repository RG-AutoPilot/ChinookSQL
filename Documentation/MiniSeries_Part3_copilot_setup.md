# Agentic Workflows with Flyway — Part 3: `copilot-setup-steps.yml`

*Part 3 of four. [Part 2](./MiniSeries_Part2_agent_md.md) wrote the `agent.md` that tells the AI to hand script generation to Flyway. This post gives the agent a Flyway install and a shadow database to actually talk to.*

There's a gap in what we've built so far. `agent.md` says *"call the Flyway MCP server"*. The MCP config from Part 2 says *"here's how to expose Flyway as a tool"*. Neither of those installs Flyway. Neither of those spins up a shadow database. If the Copilot agent boots into a runner with no Flyway binary and no SQL Server, the very first tool call fails.

`copilot-setup-steps.yml` is what closes that gap. It's a GitHub Actions workflow with a specifically-named job that Copilot runs as the preamble to every agent session. Install Flyway, write credentials, start SQL Server, create the shadow database, verify Enterprise is licensed — all before the agent gets to touch anything.

Think of it as the equivalent of a `Dockerfile` for the agent's workspace. Boring, mechanical, and completely load-bearing.

## The naming rule

The file must live at `.github/workflows/copilot-setup-steps.yml` and the job inside it must be named exactly `copilot-setup-steps`. That specific name is how GitHub identifies which workflow to run before the agent starts. Get either wrong and Copilot will silently skip it, and the agent will fail on its first Flyway call for reasons that make no sense.

## What our setup actually does

Ten steps, in order. Here's what each one is for, before we look at the yaml.

1. **Check out the repo** so the Flyway install script and the permit-writing step have access to the files.
2. **Install the Flyway CLI** using a script from `Scripts/Flyway_DownloadAndInstallCLI.sh`.
3. **Write the Flyway offline permit** from a GitHub secret to `/tmp/permit.txt`, where the MCP server expects to find it.
4. **Verify `SQL_SA_PASSWORD` is set** — fail loudly here if the secret's missing, rather than 5 steps later with a cryptic container error.
5. **Pull the SQL Server 2019 image** as its own step so image-pull failures are easy to spot in the log.
6. **Start SQL Server** in a Docker container.
7. **Wait for SQL Server to be ready** with a 30-attempt / 2.5-minute polling loop.
8. **Dump container logs on failure** so if anything above went wrong, you get the real SQL Server error.
9. **Create the `Chinook_Shadow` database** — that's the build database Flyway uses when generating migrations.
10. **Verify the Enterprise licence** is picked up correctly. If Flyway boots as Community Edition, fail the setup — the compare engine we need for V3 doesn't exist in Community.

## The file, in full

```yaml
name: "Copilot Setup Steps"

on:
  workflow_dispatch:
  push:
    paths:
      - .github/workflows/copilot-setup-steps.yml
  pull_request:
    paths:
      - .github/workflows/copilot-setup-steps.yml

jobs:
  # Job name must be exactly 'copilot-setup-steps' — GitHub uses this to
  # identify the file.
  copilot-setup-steps:
    runs-on: ubuntu-latest

    permissions:
      contents: read

    env:
      FLYWAY_OFFLINE_PERMIT_PATH: $HOME/.flyway/permit.txt
      SQL_SA_PASSWORD: ${{ secrets.SQL_SA_PASSWORD }}

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Install Flyway CLI
        run: |
          chmod +x ./Scripts/Flyway_DownloadAndInstallCLI.sh
          ./Scripts/Flyway_DownloadAndInstallCLI.sh

      - name: Write Flyway offline permit
        env:
          FLYWAY_OFFLINE_PERMIT: ${{ secrets.FLYWAY_PERMIT_FILE }}
        run: |
          if [ -z "$FLYWAY_OFFLINE_PERMIT" ]; then
            echo "ERROR: FLYWAY_OFFLINE_PERMIT secret is not available."
            exit 1
          fi
          printf "%s" "$FLYWAY_OFFLINE_PERMIT" > "$HOME/.flyway/permit.txt"
          chmod 600 "$HOME/.flyway/permit.txt"
          printf "%s" "$FLYWAY_OFFLINE_PERMIT" > "/tmp/permit.txt"
          chmod 600 "/tmp/permit.txt"

      - name: Verify SQL_SA_PASSWORD is set
        env:
          SQL_SA_PASSWORD: ${{ secrets.SQL_SA_PASSWORD }}
        run: |
          if [ -z "${SQL_SA_PASSWORD}" ]; then
            echo "ERROR: SQL_SA_PASSWORD secret is not available."
            exit 1
          fi

      - name: Pull SQL Server 2019 Docker image
        run: docker pull mcr.microsoft.com/mssql/server:2019-latest

      - name: Start SQL Server container
        env:
          SQL_SA_PASSWORD: ${{ secrets.SQL_SA_PASSWORD }}
        run: |
          docker run \
            --name sqlserver_agent \
            -e ACCEPT_EULA=Y \
            -e SA_PASSWORD="${SQL_SA_PASSWORD}" \
            -p 1433:1433 \
            -d mcr.microsoft.com/mssql/server:2019-latest

      - name: Wait for SQL Server to be ready
        env:
          SQL_SA_PASSWORD: ${{ secrets.SQL_SA_PASSWORD }}
        run: |
          for i in {1..30}; do
            if docker exec -e SA_PW="${SQL_SA_PASSWORD}" sqlserver_agent bash -c '
              /opt/mssql-tools18/bin/sqlcmd -C -S localhost -U sa -P "$SA_PW" -Q "SELECT 1"
            ' > /dev/null 2>&1; then
              echo "SQL Server ready after attempt $i."
              break
            fi
            sleep 5
            if [ "$i" -eq 30 ]; then
              echo "SQL Server did not become ready in time."
              exit 1
            fi
          done

      - name: Dump SQL Server container logs
        if: failure()
        run: docker logs sqlserver_agent

      - name: Create Chinook_Shadow database
        env:
          SQL_SA_PASSWORD: ${{ secrets.SQL_SA_PASSWORD }}
        run: |
          docker exec -e SA_PW="${SQL_SA_PASSWORD}" sqlserver_agent bash -c '
            /opt/mssql-tools18/bin/sqlcmd -C -S localhost -U sa -P "$SA_PW" \
              -Q "CREATE DATABASE Chinook_Shadow"
          '

      - name: Verify Flyway Enterprise licence
        env:
          SQL_SA_PASSWORD: ${{ secrets.SQL_SA_PASSWORD }}
        run: |
          OUTPUT=$(flyway info \
            "-offlinePermitPath=/tmp/permit.txt" \
            "-environments.shadow.url=jdbc:sqlserver://localhost:1433;databaseName=Chinook_Shadow;encrypt=false;trustServerCertificate=true" \
            "-environments.shadow.user=sa" \
            "-environments.shadow.password=${SQL_SA_PASSWORD}" \
            "-environment=shadow" 2>&1)
          echo "$OUTPUT"
          if echo "$OUTPUT" | grep -q "Community Edition"; then
            echo "ERROR: Flyway is running as Community Edition."
            exit 1
          fi
```

Points worth calling out:

- **The permit file gets written to two places** — `$HOME/.flyway/permit.txt` and `/tmp/permit.txt`. The Flyway CLI checks `FLYWAY_OFFLINE_PERMIT_PATH` for its own commands, but the MCP server (launched as a subprocess from `agent.md`) reads `/tmp/permit.txt` directly. Writing both keeps everything happy.
- **`SQL_SA_PASSWORD` is set at job level AND at each step that needs it.** In theory job-level env should be enough. In practice, Copilot-agent-triggered runs sometimes come back with empty job-level secrets. Setting it at step level as well is defensive — belt and braces.
- **Verify Enterprise, not just Flyway.** Step 10 greps the `flyway info` output for `"Community Edition"` and fails if it's there. Without that check, a bad permit gives you a Flyway install that happily boots — and then quietly refuses to run the compare engine at generate time, ten minutes into the agent's task.
- **`docker logs sqlserver_agent` on failure.** SQL Server container failures are cryptic on their own — the actual error is inside the container log. Dumping it on failure turns a five-hour debug session into a five-minute one.

## The credential question

This file runs in an environment where the AI is about to start editing your database schema. Everything about how you supply credentials matters.

The rules I stick to:

- **No secret is ever inline.** Everything sensitive comes from GitHub Actions secrets — `${{ secrets.SQL_SA_PASSWORD }}`, `${{ secrets.FLYWAY_PERMIT_FILE }}`. Never a literal.
- **The agent only reaches what it's supposed to reach.** The setup only creates `Chinook_Shadow`. There's no production credential in this file. That's deliberate — Prod credentials live in the release workflow, not the agent's setup.
- **Scoped credentials.** The `sa` account inside the ephemeral container is fine here because the container gets torn down at the end of the run. Nothing about it grants access to anything real.

If you're tempted to shortcut any of this, remember: the whole reason we're in V3 is that we're letting AI make database changes. Every guardrail from V2 still applies, and this file is one of the load-bearing ones.

## Verifying the agent's environment

Once `copilot-setup-steps.yml` is in place, kick off a Copilot session and ask the agent to do the same small task from Part 2 — add a `LastModifiedBy` column to `Customer`. Watch the setup logs before the agent starts its edits.

You want to see, in order:

1. Flyway CLI installed successfully.
2. Permit file written to both paths.
3. SQL Server container started, healthy after ~30s.
4. `Chinook_Shadow` created.
5. `flyway info` returns without the word `Community` anywhere in it.
6. Only *then* does the agent begin editing the schema model.

If setup fails, you don't want a half-configured agent guessing its way through. The setup fails fast, fails loud, and the agent never runs.

[TODO: screenshot — a Copilot agent run showing the setup phase completing (all 10 steps green), then the schema-model edits kicking off in the same run]

## Common problems

A few things I've hit that are worth flagging up front:

- **Job-level secret propagation.** As noted above — Copilot-agent-triggered runs don't reliably resolve `secrets.*` at job level. Set them at step level too, at least until GitHub sorts this out.
- **Wrong licence tier.** The compare engine V3 depends on is Flyway Enterprise. Community and Teams won't cut it. Step 10 exists because of this.
- **Permit-in-secret gotchas.** GitHub secrets strip trailing newlines. If the Flyway permit file needs the exact bytes, use `printf "%s"` (not `echo`) when writing it out — `echo` will append a newline that breaks the permit.

## What we've got

At the end of Part 3, we have an agent runtime that:

- Installs Flyway CLI automatically.
- Writes credentials safely via GitHub secrets.
- Spins up a clean SQL Server + shadow DB for the agent to compare against.
- Verifies Enterprise is licensed before letting the agent run.
- Fails fast if anything's wrong, so we don't debug half-broken agents.

The AI can now edit the schema model, call the Flyway MCP to generate a migration, and open a pull request. The build stage from [Part 1](./MiniSeries_Part1_Base_Flyway_Project.md) runs on that PR. A human reviews.

That's the workflow. What's left is the release — and the audit trail that makes any of this defensible when the auditor turns up. That's **Part 4**.
