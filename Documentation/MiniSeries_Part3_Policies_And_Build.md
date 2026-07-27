# Agentic Workflows with Flyway — Part 3: Repo policies and the PR build

*Part 3 of four. [Part 2](./MiniSeries_Part2_AI_Behaviour_And_MCP.md) taught the AI what to do. This post is about making sure it can't do anything else.*

An AI reads `agent.md` and *usually* follows it. Sometimes it doesn't. Sometimes a human is in a hurry and pushes something the AI would never have written. Sometimes the AI writes something perfect and the migration set as a whole is still broken — a rename that clashes with an earlier one, a stored procedure that references a column an older migration removed, a rule violation the AI didn't spot.

The point of this post is that **none of that reaches production, ever**, because of two things:

1. **Branch protection on `main`** — the AI (and any human) is physically prevented from pushing straight to main. Everything goes through a pull request.
2. **A build stage that runs on every pull request** — before a human is asked to review, GitHub Actions has already checked that the migrations deploy, that they obey the code analysis rules, and that the tSQLt tests still pass.

Neither of these is AI-specific. They're the same guardrails you'd apply to a room full of humans. The AI just makes it more obvious how much you need them.

## 1. Branch protection on `main`

This is where a lot of teams stop short. They set up version control, but leave `main` writable. Then the AI (or a human in a hurry) pushes straight to it and we're back to running scripts blind at production.

Go to **Settings → Branches → Add branch ruleset** (or **Branch protection rules**, depending on your GitHub UI) and target `main`. The rules I set:

- **Restrict deletions.**
- **Require a pull request before merging.**
  - At least one approving review.
  - Dismiss stale approvals when new commits are pushed.
- **Require status checks to pass before merging.**
  - Required check: **Flyway Build Pipeline** (the build we're about to build).
- **Block force pushes.**
- **Include administrators.** If you exclude yourself, "just this once" becomes the rule. Include yourself.

[TODO: screenshot — GitHub branch protection rules for `main`, showing the Flyway Build Pipeline listed as a required check]

The AI will always work on a feature branch. Not because we told it to be polite, but because the branch policy makes anything else impossible. Everything the AI produces has to pass through the same PR + build + review gauntlet as everything else.

## 2. The build stage

The build is the safety net. It runs on every pull request — before a human ever looks — and answers three questions:

1. Does this code actually deploy against a clean database?
2. Does it obey the code analysis rules we care about?
3. Do the unit tests still pass?

The file lives at `.github/workflows/FlywayBuildOnly.yml`. Here's the meat of it, trimmed to the key steps:

```yaml
name: Flyway Build Pipeline

on:
  pull_request:
    types: [opened, synchronize, reopened, ready_for_review]
    paths:
      - 'migrations/**'
  workflow_dispatch:

jobs:
  generate-and-build:
    runs-on: huxLocal
    environment: 'build'
    env:
      ENVIRONMENT: 'Build'
      DATABASE_NAME: 'Chinook_Build'
      TARGET_DATABASE_USERNAME: "${{ secrets.TARGET_DATABASE_USERNAME }}"
      TARGET_DATABASE_PASSWORD: "${{ secrets.TARGET_DATABASE_PASSWORD }}"

    steps:
      - name: Checkout PR branch
        uses: actions/checkout@v4
        with:
          ref: ${{ github.head_ref }}

      # Prove the migrations deploy cleanly against an empty build DB
      - name: Validate Migrate Scripts
        run: |
          flyway info migrate info -environment="${{ env.ENVIRONMENT }}" `
            -user="${{ env.TARGET_DATABASE_USERNAME }}" `
            -password="${{ env.TARGET_DATABASE_PASSWORD }}" `
            -cleanDisabled=false `
            -baselineOnMigrate=true `
            -configFiles="${{ github.workspace }}\flyway.toml"

      # Change report + code analysis against the Prod schema
      - name: Flyway Check Report - Code Analysis
        run: |
          flyway check -changes -code -environment="Prod" `
            "-check.buildEnvironment=${{ env.ENVIRONMENT }}" `
            "-check.rulesLocation=${{ github.workspace }}\rules" `
            "-check.rulesConfig=${{ github.workspace }}\sqlfluff.cfg" `
            -reportEnabled=true

      # Install and run tSQLt unit tests
      - name: Flyway - Install Unit Tests
        run: |
          flyway prepare deploy -environment="Build" `
            -workingDirectory="${{ github.workspace }}\UnitTests" `
            "-prepare.source=schemaModel" `
            "-prepare.target=Build" `
            "-prepare.types=deploy"

      - name: Run tSQLt Tests
        shell: pwsh
        run: |
          Invoke-Sqlcmd -ServerInstance "localhost\sqlexpress" `
            -Database "${{ env.DATABASE_NAME }}" -TrustServerCertificate `
            -Query "EXEC tSQLt.RunAll; EXEC tSQLt.XmlResultFormatter"

      # Upload SARIF results so findings show up in the PR UI
      - name: Upload SARIF to GitHub Code Scanning
        uses: github/codeql-action/upload-sarif@v4
        with:
          sarif_file: reports\Chinook_Build-CI-Run-${{ github.run_id }}-Check-Report-code-review.sarif
          category: flyway-code-analysis
```

The three commands doing the real work:

- **`flyway migrate` against a clean `Chinook_Build`.** Proves the entire migration set deploys from empty without errors. This is where a broken rename or a bad dependency will trip up.
- **`flyway check -changes -code`** — generates the change report and runs code analysis against the rules in `Rules/`. `buildEnvironment=Build` tells Flyway to build a clean copy from the migrations and compare it against Prod's schema.
- **`flyway prepare deploy` + `tSQLt.RunAll`** — installs the tSQLt tests against the freshly-built database and runs them.

**The SARIF upload at the end is what makes the code analysis findings show up on the PR itself**, not buried in an artifact zip file. That's the difference between "we checked" and "the reviewer can see it without leaving the PR."

[TODO: screenshot — a passing PR build in GitHub Actions, checks green, SARIF findings visible on the Files Changed tab]

## Why the order matters

You'll notice the trigger is `pull_request` — the build starts the second the PR opens (or gets a new commit). What that gives you is this:

> **The build runs and every quality gate passes before a human ever looks at the pull request.**

By the time a reviewer clicks into the PR, the checks are either green (in which case they can spend their attention on the *logic* of the change) or red (in which case they can bounce the PR back without reading it). Every AI workflow I've seen that skips this step ends up moving the bottleneck onto the review — the AI produces changes faster than people can read them, and the reviewer becomes both the smart-check and the dumb-check.

Automating the dumb checks is what keeps the review fast and meaningful.

## Making the check *required*

A build that runs but doesn't gate the merge is decoration. Two things wire it up as a real gate:

1. **Branch protection lists it as a required status check.** You set this up in the branch rule at the top of this post. It won't appear as an option until the workflow has run at least once, so open a throwaway PR to trigger it first, then come back and select it as required.
2. **The workflow triggers on `pull_request`, not `push`.** The distinction matters — `pull_request` runs the workflow in the context of the merge preview, which is the state that would land on `main`. `push` runs against the branch as-is, which can pass on the branch but fail on merge.

## What "green" actually means here

A green Flyway Build Pipeline says:

- The entire migration set (not just the new script) deploys cleanly from an empty database.
- Nothing violates the code analysis rules in `Rules/` — no `SELECT *`, no unguarded `TRUNCATE`, no `DROP` without a check, whatever else your team cares about.
- The tSQLt tests still pass against the freshly-built schema.
- The change report has been generated and is available as an artifact for the reviewer.

That's what the human sees before deciding whether to approve.

## What we've got

At the end of Part 3, the repo forces every change — AI-authored or otherwise — through the same gate:

- Direct pushes to `main` are impossible.
- Every change goes via a pull request.
- The PR triggers a build that migrates, checks, and tests.
- The reviewer sees the build result and the SARIF findings before approving.
- Nothing merges until the check is green and a human has approved.

This is the point at which I stop worrying about the AI. Everything it produces is on the same rails as everything else.

What's left is the actual release — the deploy to Test and Prod, the change and drift reports that turn "we approved a migration" into "we know exactly what will happen and we know the target isn't already off-piste", and the environment gate that pauses the pipeline for a final human sign-off before Prod. That's **Part 4**.
