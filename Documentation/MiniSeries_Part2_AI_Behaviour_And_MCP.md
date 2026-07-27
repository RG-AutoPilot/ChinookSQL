# Agentic Workflows with Flyway — Part 2: Setting AI behaviour with `agent.md` and MCP

*Part 2 of four. [Part 1](./MiniSeries_Part1_Agent_Runtime.md) gave the agent a runtime — Flyway installed, permit written, shadow DB ready. Now we teach the AI what to do inside it.*

The single biggest shift in an agentic Flyway workflow is this: **the AI stops writing migrations.** Instead, it edits the schema model, and Flyway's compare engine turns the diff into a deterministic migration script.

Two files make that shift real:

- **`agent.md`** — the AI's onboarding document. Scope, workflow, environment. Read into context every time the agent runs.
- **`.mcp.json`** — the wiring that turns the Flyway CLI into a set of callable tools.

Get these right and the AI behaves like a member of the team. Get them wrong and it'll do exactly what it does with no guardrails — write migrations from scratch and hope for the best.

## What `agent.md` actually is

If you've used GitHub Copilot's agent mode, you've seen `agent.md`. It's a plain markdown file that sits in the repo and gets read into the AI's context every time the agent runs. Think of it as the onboarding doc you'd give a new junior developer on their first day, except the junior reads it every single time.

Ours lives at `.github/agents/flyway-mcp-agent.md`. The `.github/agents/` folder is where GitHub Copilot picks it up automatically.

## What ours needs to say

Four things, in order of importance:

1. **Edit the schema model, not the migrations folder.** Migrations are generated. If the AI writes one by hand, we've lost the whole point.
2. **When the model changes, call the Flyway MCP server to generate the migration.** Not "sometimes" — every time.
3. **Fail loudly if generation fails.** A failed generate means something in the AI's edits wasn't safe or deterministic. That's a signal, not a nuisance.
4. **Never touch `main`. Always work on a feature branch.** Branch policies (Part 3) enforce this, but telling the AI up front saves a wasted round-trip.

## The `agent.md` I actually use

Here it is in full, from `.github/agents/flyway-mcp-agent.md`:

```markdown
---
name: flyway-mcp-agent.md
description: Generates Flyway Enterprise migration scripts from schema model changes.
mcp-servers:
  flyway-mcp:
    type: 'local'
    command: 'flyway'
    args: ['mcp', '-mcp.toolsets=all']
    tools: ["*"]
    env:
      "REDGATE_FLYWAY_MCP_SERVER_FEATURE": "true"
      "FLYWAY_OFFLINE_PERMIT_PATH": "/tmp/permit.txt"
      "SQL_SA_PASSWORD": "$COPILOT_MCP_SQL_SA_PASSWORD"
---

You are a database migration assistant for Redgate Flyway Enterprise. Your only
job is to make schema changes to the schema model and generate a migration
script from those changes using the Flyway MCP Server.
Only use this Agent.MD, never call or invoke other Agent.MD

## Scope

You are allowed to:
- Read and ONLY modify files inside `schema-model/`
- Only use the Flyway MCP Server to call Flyway commands.
- Create a new branch and open a pull request

## NEVER Write a V / U / B Migration Script yourself, only ever use the Flyway MCP to translate edited schema model files into a Flyway migration script.

You must also never:
- Modify anything inside `migrations/`
- Modify `flyway.toml`
- Modify any file inside `.github/`
- Modify any other file outside `schema-model/`

If a task asks you to do anything outside this scope, decline and explain why.

## Environment

The following is already set up and ready to use. You do not need to install
or configure anything.

- Flyway CLI is installed and available on PATH
- Flyway Enterprise is licensed via an offline permit file at `/tmp/permit.txt`
- SQL Server 2019 is running at `localhost:1433`
  - Username: `sa`
  - Password: available via `$SQL_SA_PASSWORD` environment variable
  - Shadow database: `Chinook_Shadow`

The Flyway project root is the repository root. `schema-model/`, `migrations/`,
and `flyway.toml` all live at the root level.

## Workflow

Follow these steps in order. Do not skip any step. Do not proceed to the next
step if the current one fails.

### Step 1: Understand the task
Read the issue or task description carefully. Identify exactly what schema
changes are needed. If the description is ambiguous, inspect the existing files
in `schema-model/` to understand the current state of the database.

### Step 2: Make schema model changes
Edit only the relevant files inside `schema-model/`. Do not touch any other
files. Make the minimum changes necessary to satisfy the task.

### Step 3: Generate the migration script using the Flyway MCP Server
Once schema model changes are complete, generate a migration using the flyway
mcp server configured. If this fails, stop and report the full error output.
Do not attempt to manually create or edit migration files.

### Step 4: Verify the script was generated
Check that at least one new `.sql` file now exists in `migrations/`. If no file
was created, report the error and stop. Do not continue to step 5.

### Step 5: Verify Code Follows All Code Rules
Use the Flyway MCP Server to check code against code analysis, as well as
passing the code review and thoughts into the PR Notes.

### Step 6: Wait for Pull Request
Do not skip CI, do not open the PR yourself. Allow a human to create the PR
once you are done, to make sure CI is triggered and Build.
```

## The parts that matter

**The `mcp-servers` block in the frontmatter is the killer feature.** GitHub Copilot reads this and boots the Flyway MCP server for the agent automatically. No separate config, no manual "connect this MCP" step — the agent file *is* the config. Line by line:

- `type: 'local'` — the MCP server runs as a subprocess on the agent's runner, not over HTTP.
- `command: 'flyway'` + `args: ['mcp', '-mcp.toolsets=all']` — launches the Flyway CLI in MCP-server mode, with every toolset exposed. Every Flyway command becomes a tool the AI can call.
- `env.REDGATE_FLYWAY_MCP_SERVER_FEATURE: "true"` — the MCP server is opt-in at the time of writing.
- `env.FLYWAY_OFFLINE_PERMIT_PATH: "/tmp/permit.txt"` — points the MCP subprocess at the permit written by Part 1's setup. This is why Part 1 writes the permit to `/tmp/permit.txt` specifically.
- `env.SQL_SA_PASSWORD: "$COPILOT_MCP_SQL_SA_PASSWORD"` — Copilot's own indirection for injecting a secret into an MCP subprocess. The secret is defined in the repo, referenced by name here.

**The "only use this Agent.MD" line matters.** If you have more than one `agent.md` in the repo (I originally had a CLI-based one and this MCP-based one), Copilot will pick one and stick with it. Telling the AI not to call the others prevents cross-contamination if you're mid-migration between versions.

**The scope list is intentionally aggressive.** `schema-model/` in, everything else out. `migrations/`, `flyway.toml`, `.github/` — all off-limits. If a task requires touching any of those, the agent should decline. Better a declined task than a rogue commit.

**The exact environment is spelled out.** The permit path, the SQL Server host, the shadow database name — everything the MCP server needs to work. Putting it in the agent file lets the AI reason about failures ("permit missing at `/tmp/permit.txt`") rather than guessing.

**The workflow section forces the order.** Understand → edit model → generate via MCP → verify a file landed in `migrations/` → run code analysis → stop and wait for a human to open the PR. That last step is subtle but important: if the agent opens the PR itself, GitHub's `pull_request` triggers can behave differently for AI-authored PRs. Waiting for a human means CI is guaranteed to fire the same way it does for any other change.

## `.mcp.json` — for local agents

The frontmatter block in `agent.md` is how GitHub Copilot picks up the MCP server. If you're also running Copilot, Cursor, or Claude Code locally against the same repo, they read a different file: `.mcp.json` at the repo root.

```json
{
  "mcpServers": {
    "flyway": {
      "type": "stdio",
      "command": "flyway",
      "args": ["mcp","-mcp.toolsets=all"],
      "env": {
        "REDGATE_FLYWAY_MCP_SERVER_FEATURE": "true",
        "FLYWAY_OFFLINE_PERMIT_PATH": "permit.txt"
      }
    }
  }
}
```

Same idea as the frontmatter — launch `flyway mcp -mcp.toolsets=all` as a subprocess, turn on the feature flag, point at the permit file. The differences from the Copilot version:

- `"type": "stdio"` (the JSON-RPC-over-stdio convention most local agents use) vs `"type": "local"` in the Copilot frontmatter.
- The permit path is relative to the repo root (`permit.txt`) rather than `/tmp/permit.txt`, because locally you don't need to bridge into a subprocess with its own filesystem view.
- No `SQL_SA_PASSWORD` — your local Flyway config already knows how to reach your dev database.

You want both files if you're switching between "kick off a Copilot session from GitHub" and "iterate locally with Copilot / Cursor / Claude Code". They don't conflict — each tool reads the file it's looking for.

[TODO: screenshot — Flyway MCP tools showing up in Copilot's tool picker, or a chat transcript of the agent calling the migration-generation tool]

## Testing the agent

Ask the AI for something small and watch what happens. My go-to first test:

> Add a `LastModifiedBy` column to the `Customer` table.

If `agent.md` and the MCP are wired up correctly, you should see:

1. The AI edits `schema-model/Tables/dbo.Customer.sql`. No file appears in `migrations/`.
2. The AI calls the Flyway MCP's migration-generation tool.
3. A new versioned migration script (something like `V019_20260721__AIAgent_AutomatedMigrationScript.sql`) appears in `migrations/`.
4. The AI reports back with the code analysis output for review.

If any step is missing, `agent.md` needs sharpening. Common misses:

- **AI writes a migration by hand** → the "NEVER Write a V / U / B Migration Script yourself" line wasn't strong enough. Move it higher in the file, put it in caps, add another instance in the workflow steps.
- **AI edits the model but never generates** → Step 3 isn't specific enough. Reference the MCP tool by name.
- **AI pushes to main** → your branch policy from [Part 3](./MiniSeries_Part3_Policies_And_Build.md) will catch it, but tighten the scope section in `agent.md` too.

## What we've got

At the end of Part 2, the AI knows:

- Where to edit (`schema-model/`).
- Where not to edit (`migrations/`, `flyway.toml`, `.github/`).
- When to call Flyway (every model change).
- How to call Flyway (through the Flyway MCP server, whether launched by Copilot or a local agent).
- What to do when generation fails (surface it, don't hide it).

The AI is scoped, the runtime is ready, and Flyway is a callable tool. But nothing in the repo *forces* the AI to follow any of this. If the AI (or a rushed human) ignores `agent.md` and pushes straight to `main`, we're back to a horror movie.

**Part 3** is what makes the guardrails real. Branch protection, required checks, and a build stage that runs on every pull request.
