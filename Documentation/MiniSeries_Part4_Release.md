# Agentic Workflows with Flyway — Part 4: The release

*Part 4 of four — the finale. [Part 3](./MiniSeries_Part3_copilot_setup.md) gave the agent a Flyway install and credentials. Now the AI's PR is green, a human has approved, and we're ready to release. This post is about making that release safe, gated, and defensible.*

The release is where V3 earns its keep. Everything up to this point — schema model, `agent.md`, MCP, `copilot-setup-steps.yml`, build stage — was about making sure the AI can produce a *candidate* change safely. The release is where we prove that what's about to touch production is what we think it is.

Two artifacts do the heavy lifting: the **change report** and the **drift report**. Both are Flyway Enterprise features. Both are things you can generate before you release, so nothing is a surprise.

## The release pipeline

The full release pipeline lives at `.github/workflows/GitHub-Flyway-CICD-Pipeline_Windows.yml`. It's triggered when a merge lands on `main` that touches `migrations/**` — i.e. when the AI's script (produced in Part 2, validated by the build in Part 1) has been reviewed and approved by a human.

The pipeline has three jobs, wired in sequence: `build` → `test` → `prod`.

```yaml
on:
  push:
    branches: [main]
    paths:
      - 'migrations/**'
  workflow_dispatch:

jobs:
  build:
    environment: 'build'
    # Re-runs the PR build against a clean DB — proves nothing broke on merge

  test:
    needs: build
    environment: 'test'
    # Generates change + drift reports against Test, then migrates Test

  prod:
    needs: test
    environment: 'prod'
    # Generates change + drift reports against Prod, then migrates Prod
```

`environment: 'prod'` is doing something important — it hooks into GitHub Environment protection rules. Which brings us to the gate.

## Gating the release with GitHub Environments

Before Flyway touches production, a human clicks approve. That gate is set up in the repo settings, not in the workflow file:

**Settings → Environments → `prod` → Required reviewers.**

Add the reviewers there. When the pipeline reaches the `prod` job, it pauses. Nothing deploys until a reviewer clicks approve. The reviewer clicks approve *after* they've read the reports we're about to generate.

[TODO: screenshot — GitHub Environments settings for `prod`, showing required reviewers]

## The change report

The change report answers one question: **what will this release do to the database?**

Not "what does the migration file say" — the migration file is a means, not an end. The change report tells you the actual set of DDL Flyway is about to run against the target environment.

The `prod` job generates it before deploying:

```yaml
- name: Create Check Reports
  run: |
    flyway check -dryrun -changes -drift `
      -environment="Prod" `
      -user="${{ env.TARGET_DATABASE_USERNAME }}" `
      -password="${{ env.TARGET_DATABASE_PASSWORD }}" `
      -configFiles="${{ github.workspace }}\flyway.toml" `
      -locations="filesystem:${{ github.workspace }}\migrations" `
      "-check.buildEnvironment=Check" `
      "-reportFilename=${{ github.workspace }}\reports\AutoPilotProd-Run-${{ github.run_id }}-Prod-Check-Report.html"

- name: Publish Check Report as Artifact
  uses: actions/upload-artifact@v4
  with:
    name: flyway-reports-prod
    path: reports\AutoPilotProd-Run-${{ github.run_id }}-Prod-Check-Report.html
```

`flyway check -dryrun -changes -drift` does three things in one call:

- **`-dryrun`** — connects to Prod, works out what would happen, but doesn't run any DDL.
- **`-changes`** — produces the change report: exactly what statements will run when we do release.
- **`-drift`** — produces the drift report at the same time (more on this below).

The report is uploaded as an artifact so the reviewer can read it from the paused deploy in Actions.

[TODO: screenshot — the change report showing the specific DDL statements queued for deployment]

For an AI-driven workflow this is priceless. When the AI committed the schema-model edit, we trusted `agent.md` to keep it in scope. When Flyway generated the migration, we trusted the compare engine to be deterministic. The change report is the third and final check: *this, and only this, is about to happen.*

If the report shows something you didn't ask for — a column drop you didn't authorise, a table rename that shouldn't be there — you stop the release. Not "roll it back after." Stop it now, before approving the gate.

## The drift report

Drift is when production has quietly diverged from what version control says it should look like. Someone made a hotfix in SSMS at 2am. A previous release half-failed and nobody cleaned up. A tool wrote objects nobody documented.

Drift always happens eventually. What matters is knowing about it *before* you deploy on top of it.

The same `flyway check -dryrun -changes -drift` command produces the drift section of the same report. `-check.buildEnvironment=Check` is Flyway building a clean copy of what version control says the DB should look like, then comparing that against Prod.

[TODO: screenshot — the drift report showing an unexpected object in Prod that isn't in version control]

The workflow with drift:

1. Read the drift report. What's in production that shouldn't be?
2. Cross-reference against the change report. Does the release touch anything that's drifted?
3. **If no overlap:** safe to release. Note the drift, deal with it separately.
4. **If overlap:** stop. Either reconcile the drift into version control first, or hold the release.

That cross-reference is the moment where "AI-generated database change" stops being scary. You know exactly what's changing. You know exactly what's already off-piste. You know they don't collide.

## The compliance angle

SOX, DORA, and GDPR all care about the same three things when it comes to database change:

1. **Was the change authorised?** — The PR approval in GitHub answers this. Named human, timestamp, immutable record.
2. **Do we know exactly what happened?** — The change report answers this. Not "we ran a migration" but "we ran these specific DDL statements at this specific time against this specific target."
3. **Can we prove the target wasn't already in an unexpected state?** — The drift report answers this.

None of this is optional if you're regulated. All of it becomes materially harder to defend if AI is in the change pipeline and you *don't* have these reports. The reports are what let you look an auditor in the eye and say *yes, we let AI edit our schema, and here's the trail proving every change was checked, gated, and safe.*

Reports are uploaded as GitHub Actions artifacts on every run, which gives you a permanent, timestamped record tied to the specific pipeline run that produced them. GitHub retains those for as long as you configure — 90 days is the default; regulated environments should extend it or ship the artifacts to longer-term storage.

## The full flow, end to end

Here's what a release looks like from the moment the AI opens its branch to the moment production is updated:

1. **Copilot boots.** `copilot-setup-steps.yml` runs — Flyway installed, permit written, shadow DB created, Enterprise licence verified.
2. **Agent runs.** `flyway-mcp-agent.md` scopes it to `schema-model/`. It edits the relevant SQL files.
3. **Migration generated.** The agent calls the Flyway MCP; a versioned script drops into `migrations/`.
4. **PR opened.** A human opens the PR — the agent deliberately doesn't, so CI is guaranteed to fire.
5. **Build runs.** `FlywayBuildOnly.yml` — deploy check, code analysis, tSQLt tests. Blocks merge if any fail.
6. **Human reviews.** Reads the code, reads the SARIF findings, reads the build output. Approves or rejects.
7. **Merge to main.** Triggers `GitHub-Flyway-AutoPilot-Pipeline-Windows`.
8. **Build re-runs.** `build` job in the release pipeline confirms nothing broke on merge.
9. **Test deploys.** `test` job generates reports against Test, then migrates Test.
10. **Prod pauses at the gate.** `prod` job generates the change and drift reports against Prod, then pauses at the `prod` environment for reviewer approval.
11. **Reviewer approves.** After reading both reports.
12. **Flyway deploys to Prod.**
13. **Reports retained.** As build artifacts, tied to the run ID.

[TODO: screenshot — a paused release in GitHub Actions, showing the prod environment awaiting approval, with the change and drift report artifacts linked]

Compare this to V1 — human writes prompt, AI writes script, someone runs it straight at production. The release above is barely slower, and it's a completely different risk profile.

## We're done

Across the four parts we've built V3:

- **Part 1** — a Flyway project in GitHub, schema model tracked as plain SQL, branch policies protecting main, build stage running on every PR.
- **Part 2** — an `agent.md` at `.github/agents/flyway-mcp-agent.md` that tells the AI to edit the model and hand script generation to Flyway, plus a `.mcp.json` that makes the Flyway CLI callable as MCP tools.
- **Part 3** — a `copilot-setup-steps.yml` that installs Flyway, writes the permit, spins up SQL Server and the shadow database, and verifies Enterprise before the agent runs.
- **Part 4** — a gated release with change and drift reports reviewed before every deploy, artifacts retained for audit.

Everything in that stack is off-the-shelf. Flyway Enterprise, GitHub, and a bit of markdown and yaml. What it buys you is the ability to say *yes* to AI on your database with a straight face.

If you get stuck building this, reach out. We've been the leading provider of database DevOps tooling for over 20 years, and this is exactly the kind of thing our team is here for.

Look after yourself out there. Use AI wisely. And let the humans around you know they're valued.

— Huxley Kendell
