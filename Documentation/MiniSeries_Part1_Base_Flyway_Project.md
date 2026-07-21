# Agentic Workflows with Flyway — Part 1: The base Flyway project in GitHub

*Part 1 of four. If you haven't read [the main post](./Post1_Why_Safe_AI_Demands_Flyway.md), start there — it explains why we're doing any of this.*

Before we hand anything to an AI, we need somewhere safe for it to work. That means a proper Flyway Enterprise project in GitHub, a schema model the AI can read, a build stage that runs on every pull request, and branch policies that stop anything reaching main without a green build.

In V3 the AI edits the schema model and Flyway generates the migrations. None of that works if the project underneath isn't set up right. So Part 1 is the foundation — the stuff V2 already gave us, but framed as the launchpad for V3.

Here's what we'll build in this post:

1. A Flyway Enterprise project pointing at a development database.
2. A schema model, tracked in Git.
3. A GitHub repository with branch policies that force everything through a pull request.
4. A build stage that runs on every PR — deploy check, code analysis, unit tests.

## 1. Create the Flyway Enterprise project

Point Flyway Enterprise at your development database and let it capture the current state as a schema model. In my case that's a SQL Server instance running the Chinook sample database.

The `flyway.toml` for the project ends up looking like this:

```toml
databaseType = "SqlServer"
name = "Chinook (SQL Server)"

[flyway]
defaultSchema = "dbo"
locations = [ "filesystem:migrations" ]
schemaModelLocation = "schema-model"
baselineVersion = "001"
baselineOnMigrate = true

  [flyway.check]
  rulesLocation = "Rules"
  rulesConfig = "sqlfluff.cfg"

[environments.Build]
url = "jdbc:sqlserver://localhost;instanceName=sqlexpress;databaseName=Chinook_Build;encrypt=mandatory;integratedSecurity=true;trustServerCertificate=true"
displayName = "Build Database"
provisioner = "clean"

[environments.Test]
url = "jdbc:sqlserver://localhost;instanceName=sqlexpress;databaseName=Chinook_Test;encrypt=true;integratedSecurity=true;trustServerCertificate=true"

[environments.Prod]
url = "jdbc:sqlserver://localhost;instanceName=sqlexpress;databaseName=Chinook;encrypt=mandatory;integratedSecurity=true;trustServerCertificate=true"
```

The three things I want to call out:

- **`schemaModelLocation = "schema-model"`** — this is where the AI is going to be doing all its work in V3. Plain SQL files, one per object.
- **`locations = [ "filesystem:migrations" ]`** — the migrations folder is the *output* of the compare engine. Neither humans nor the AI should be editing these files by hand.
- **`[flyway.check]`** points at a `Rules` folder — our code analysis rules live there and run on every build. My rules (`DM001__NoSelectStar`, `DM003__NoTruncate`, `DM004__NoDropWithoutCheck`, and so on) are the guardrails that catch the AI when it does something stupid.

[TODO: screenshot — Flyway Desktop, project pointed at Chinook, schema model captured]

## 2. Get it into GitHub

Push the project to GitHub. My repo layout is:

```
ChinookSQL/
├── .github/
│   ├── agents/                             # agent.md files (Part 2)
│   └── workflows/                          # build + release pipelines
│       ├── FlywayBuildOnly.yml
│       ├── AutoGen.yml
│       ├── copilot-setup-steps.yml         # (Part 3)
│       └── GitHub-Flyway-CICD-Pipeline_Windows.yml
├── schema-model/                           # plain SQL, one file per object
│   ├── Tables/
│   ├── Views/
│   ├── Stored Procedures/
│   └── Data/
├── migrations/                             # generated versioned scripts
├── Rules/                                  # code analysis rules
├── UnitTests/                              # tSQLt tests
├── .mcp.json                               # (Part 2)
├── flyway.toml
└── sqlfluff.cfg
```

Nothing exotic here — this is a normal Flyway Enterprise project. The AI in later posts will edit files inside `schema-model/`, and Flyway will produce files in `migrations/`. Keeping the two visibly separate makes the audit trail obvious to anyone reading a PR diff.

## 3. Branch policies that actually protect main

This is where a lot of teams stop short. They set up version control, but leave main writable. Then the AI (or a human in a hurry) pushes straight to it and we're back to V1.

The rules I set on `main`:

- Direct pushes disabled.
- Every change goes via a pull request.
- The **Flyway Build Pipeline** check must pass before merge.
- At least one human approval required.

[TODO: screenshot — GitHub branch protection rules for main]

The AI will always work on a feature branch. Not because we told it to be polite, but because the branch policy makes anything else impossible.

## 4. The build stage

The build is the safety net. It runs on every PR — before a human ever looks — and answers three questions:

1. Does this code actually deploy against a clean database?
2. Does it obey the code analysis rules we care about?
3. Do the unit tests still pass?

Here's the meat of `FlywayBuildOnly.yml`, trimmed to the key steps:

```yaml
name: Flyway Build Pipeline

on:
  pull_request:
    types: [opened, synchronize, reopened, ready_for_review]
    paths:
      - 'migrations/**'

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
      - uses: actions/checkout@v4

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

- **`flyway migrate`** against a clean `Chinook_Build` database — proves the migration set deploys from empty without errors.
- **`flyway check -changes -code`** — generates the change report and runs code analysis against the rules in `Rules/`.
- **`flyway prepare deploy` + `tSQLt.RunAll`** — installs the tSQLt tests against the built database and runs them.

The SARIF upload at the end is the bit that makes the code analysis findings show up on the PR itself, not buried in a report artifact. That's what turns "we checked" into "the reviewer can see it."

[TODO: screenshot — a passing PR build in GitHub Actions, checks green, SARIF findings on the Files Changed tab]

The order matters. **The build runs and every quality gate passes before a human ever looks at the pull request.** By the time someone reviews, they're making an informed decision, not a blind one.

## What we've got

At the end of Part 1, we have a Flyway project in GitHub that:

- Tracks the schema model as plain SQL.
- Forces every change through a pull request.
- Runs a full build on every PR — migrate, change report, code analysis, unit tests.
- Blocks merges until the build passes and a human approves.

This is V2. It's already safer than most AI database workflows you'll see in the wild. But the AI is still writing migration scripts by hand, which is where V3 comes in.

Next, in **Part 2**, we'll write the `agent.md` — the file that tells the AI to edit the schema model and hand script generation to Flyway.
