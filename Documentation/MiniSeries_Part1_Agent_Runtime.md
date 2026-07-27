# Agentic Workflows with Flyway — Part 1: Configuring the agent's runtime

*Part 1 of four. If you haven't read [the main post](./Post1_Why_Safe_AI_Demands_Flyway.md), start there — it explains why we're doing any of this.*

This series assumes you already have a working Flyway Enterprise project — schema model captured, migrations folder in place, `flyway.toml` pointing at a development database. If you don't, get one first: **Flyway Autopilot** will do it for you in a few clicks, or the **Redgate University "Getting Started with Flyway" course** walks you through it end-to-end. Come back when you've got a repo that looks roughly like this:

```
YourProject/
├── schema-model/
├── migrations/
├── flyway.toml
└── sqlfluff.cfg
```

Now we're going to turn that project into an *agentic* one — a repo an AI can safely open pull requests against. This series covers, in order:

1. **This post — the agent's runtime.** Install Flyway, license it, and hand the agent a database to compare against.
2. **The agent's behaviour.** `agent.md` and `.mcp.json` — what the AI can touch, and how it calls Flyway.
3. **Policies and build.** GitHub branch protection and the PR build that gates every change.
4. **The release.** Change reports, drift reports, and a gated deploy to production.

## What "runtime" means here

When GitHub Copilot (or any coding agent) boots into your repo, it lands in an empty runner. No Flyway. No SQL Server. No permit file. If the very first thing the agent does is call the Flyway MCP server, it'll fail on the very first tool call.

The runtime is what closes that gap. It's a preamble that runs *before* the agent starts thinking — install the CLI, write the license, spin up a database, verify everything works. GitHub uses a specifically-named workflow file for this: **`.github/workflows/copilot-setup-steps.yml`**, with a job named exactly `copilot-setup-steps`. Get either wrong and Copilot silently skips it, and you'll spend an hour wondering why the agent can't find `flyway`.

Think of it as a `Dockerfile` for the agent's workspace — boring, mechanical, and completely load-bearing.

## The short version — use ours

If you're on SQL Server and want to move fast, drop this file into your repo at `.github/workflows/copilot-setup-steps.yml` and set two secrets in **Settings → Secrets and variables → Actions**:

- `SQL_SA_PASSWORD` — a strong password for the ephemeral SQL Server container.
- `FLYWAY_PERMIT_FILE` — the contents of your Flyway Enterprise offline permit.

That's it. Skip the rest of this post unless you want to know why each step exists, or you're running on a different database and need to adapt it. If your database isn't SQL Server, the shape of the file stays the same — swap the container image and the shadow-DB creation for your engine's equivalent.

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

## What each step is doing, and why

Ten steps, in order. Any of them can fail loud enough that the agent never starts — which is what we want.

**1. Checkout the repo.** So the install script and any project files are available to the rest of the job.

**2. Install the Flyway CLI.** Uses `Scripts/Flyway_DownloadAndInstallCLI.sh`. The script writes the install path to `GITHUB_PATH`, so `flyway` is on `PATH` for every subsequent step and — importantly — for the agent when it starts.

**3. Write the Flyway offline permit to *two* paths.** `$HOME/.flyway/permit.txt` for the CLI's own commands (via `FLYWAY_OFFLINE_PERMIT_PATH` set at job level), and `/tmp/permit.txt` for the Flyway MCP server. The MCP server is launched as a subprocess by the agent, and it reads `/tmp/permit.txt` directly regardless of what the parent env says. Writing both keeps everything happy.

**4. Verify `SQL_SA_PASSWORD` is set.** A missing password will silently fail the container start, and then the health-check loop times out with a cryptic error five steps later. Failing loud here saves debugging time. You'll notice the password is set at *both* job level and step level — that's deliberate. Copilot-agent-triggered runs don't always resolve `secrets.*` at job level, and setting it at step level as well is belt and braces.

**5. Pull the SQL Server 2019 image.** Kept as its own step so image-pull failures show up on their own line in the log.

**6. Start SQL Server.** Ephemeral container, torn down at the end of the run. Nothing about the `sa` account inside this container grants access to anything real.

**7. Wait for SQL Server to be ready.** 30 attempts, 5 seconds apart — up to 2.5 minutes. SQL Server on Docker is slow to warm up, and racing it is the fastest way to spend an evening debugging.

**8. Dump container logs on failure.** SQL Server container failures are otherwise cryptic — the actual error is inside the container log. `if: failure()` on this step turns a five-hour debug session into a five-minute one.

**9. Create the shadow database.** This is the database Flyway uses as the "build" environment when the compare engine generates a migration. Whatever your engine, this needs to exist before the agent runs.

**10. Verify Flyway is Enterprise, not Community.** This is the most important step in the file. If the permit didn't get written correctly, Flyway will happily boot as Community Edition and then quietly refuse to run the compare engine ten minutes into the agent's task. Grepping the `flyway info` output for `"Community Edition"` and failing on match catches this now, not later.

[TODO: screenshot — a green Copilot setup run in Actions with all 10 steps passed]

## The credential rules

This file runs in an environment where an AI is about to make database changes. How you supply credentials matters.

- **No secret is ever inline.** Everything sensitive comes from GitHub Actions secrets — `${{ secrets.SQL_SA_PASSWORD }}`, `${{ secrets.FLYWAY_PERMIT_FILE }}`. Never a literal.
- **The agent only reaches what it's supposed to reach.** This setup only creates `Chinook_Shadow`. There is no production credential in this file. Prod credentials live in the release workflow (Part 4), not the agent's setup.
- **Scoped credentials.** The `sa` account inside the ephemeral container is fine because the container is destroyed at the end of the run.

## Verifying it works

Trigger the workflow manually from the Actions tab. You want to see, in order:

1. Flyway CLI installed successfully.
2. Permit file written to both paths.
3. SQL Server container started, healthy after ~30 seconds.
4. `Chinook_Shadow` created.
5. `flyway info` returns without the word "Community" anywhere in it.

If any of those fail, fix it before moving on. There is no upside to running an agent against a broken runtime — you'll just get a confused AI writing confused code against a database that isn't ready.

## Common gotchas

- **Job-level secret propagation.** As noted above — Copilot-agent-triggered runs don't reliably resolve `secrets.*` at job level. Set them at step level too, at least until GitHub sorts this out.
- **Wrong licence tier.** The compare engine we depend on is a Flyway Enterprise feature. Community and Teams won't cut it. Step 10 exists because of this.
- **Permit-in-secret gotchas.** GitHub secrets can strip trailing newlines. Use `printf "%s"` (not `echo`) when writing the permit out — `echo` appends a newline that breaks the permit.

## What we've got

At the end of Part 1, the agent has a workspace that's ready before it starts:

- Flyway CLI installed and on `PATH`.
- Offline permit written where both the CLI and the MCP server can find it.
- A clean SQL Server plus a shadow database to compare against.
- A hard failure if any of the above is wrong, so the agent never runs half-configured.

None of this teaches the AI *what to do*. That's what **Part 2** is for — the `agent.md` that scopes the AI to the schema model, and the `.mcp.json` that turns Flyway into a set of callable tools.
