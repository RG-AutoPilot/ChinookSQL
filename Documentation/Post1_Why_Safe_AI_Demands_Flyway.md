# Why safe AI usage demands Flyway Enterprise

AI can make database changes faster than ever. It can also break things faster than ever. This post is about getting the speed without the risk, using a proper DevOps workflow built on Flyway Enterprise and GitHub.

I recently recorded a webinar with Steve Jones and Ken Muse from GitHub, where we built that workflow from the ground up. If you'd rather watch than read, you can find it here. This post covers the same ground. I'll take three versions of an AI database workflow, from the most dangerous to the safest, and show what each one adds:

- V1 is AI with no guardrails. It's fast, and it's terrifying.
- V2 adds version control, a build stage, and human review, so nothing reaches production unchecked.
- V3 hands script generation to a deterministic engine and locks down the audit trail, so the process is safe enough to trust at scale.

## The AI tension

There's real tension around using AI with databases. Databases are the most important, and most neglected, part of most tech stacks. They're stateful, long-lived, and full of sensitive data, and they absorb a lot of punishment without complaint, so it's easy to forget how much depends on them.

AI is massively helpful to any engineering team, and it's massively risky if it's used carelessly. Both are true at once. This isn't Schrodinger's AI box, though. The outcome you get depends on the effort and care you put into the process around it.

Most organizations don't know what to do with that, so they fall into one of two patterns. They either lock AI down to local machines, which just moves the bottleneck somewhere else, or they give it unfettered access and let engineers run wild. As a database and automation consultant, both scare me, mainly because the recent wave of AI has pushed DevOps out of people's minds at exactly the moment it matters most. The good news is that the DevOps practices we already trust are what make AI safe. Let's talk about that openly and look at how to navigate this new world.

## Bringing DevOps to your AI workflow

As a database and automation consultant, I set out to find the sweet spot: AI baked into a proper DevOps workflow, with real CI/CD, automated testing, and code analysis.

The key shift is how we think about AI. I treat any AI, whatever its success rate, as a talented but risky new junior developer. The upside is real, and I never want to slow it down. But I put guardrails around it so that nothing it produces reaches production unchecked, while keeping human review to a minimum but sensible level.

Two things heavily influence how well AI performs: how much context we give it, and how much of the process it takes part in. Get those right and the success rate climbs.

Let's go from the worst implementation I've seen to the best, one version at a time.

## V1, the horror movie

Here's the workflow I see most often, and the one that makes me feel like the only person screaming internally. The diagram below shows it: a human writes a prompt, the AI generates a migration script, and someone runs that script straight at the database, with nothing in between.

*[Diagram: V1 workflow]*

What scares me is how little sits between the prompt and production. This flow usually has no automated testing at all. Five years ago, a junior developer's code would rarely go straight to deployment like this. Somehow, in the AI era, we've forgotten good DevOps practices.

The main things wrong with this flow:

1. There's little or no testing.
2. AI is non-deterministic, so any script it writes can hallucinate.
3. There are no approval stages.
4. There's no version control, so there's no visibility into what the AI did and no context for what it does next.

There's more wrong than that, but those are the ones that stand out.

The fix is straightforward: go back to basics and add some DevOps. For me that means:

1. Adding a build stage to test the AI's work before any human reviews it.
2. Adding version control to give the AI context and enforce branching policies.
3. Testing, testing, and more testing.

## V2, DevOps plus AI

This version makes me feel genuinely safe, and in practice it's barely any slower than V1, which could have brought down the database it was pointed at.

My ideal flow for any change, whether a human or the AI makes it, has four stages:

1. Work happens on a separate branch, never straight onto main. The AI always works on a feature branch.
2. A pull request is raised when the change is ready to be released.
3. The pull request triggers a build that tests the change automatically.
4. A human reviews the pull request, sees both the code and the build result, and decides whether to approve.

The diagram below shows how those stages fit together, with the AI, Flyway Enterprise, and CI each playing a part.

*[Diagram: V2 workflow]*

The important detail is the order. The build runs and every quality gate passes before a human ever looks at the pull request, so by the time someone reviews it, they're making an informed decision, not a blind one. A lot of current AI workflows just move the bottleneck onto that review step, because the AI produces changes faster than people can check them. Automating the build is what keeps the review fast and meaningful.

Here's what I added to get there.

### Version control

The first thing I added was version control. With Flyway Enterprise, I point it at a development database, capture any new changes, and build a live schema model of that database and everyone else's on the team.

That schema model is plain SQL files, one per object, tracked in Git. Version control with Flyway Enterprise gives every developer a constant view and an audit trail of every change, without asking them to commit their work by hand. It also means the AI can see the definition of every object, how it changed, and when. That context gives the AI the best chance of getting things right, and it sets a clear precedent for how changes should be made. Version control is for humans and for AI.

### The build stage

The next addition is a Flyway build stage. It's an important step, and while it can be a chore to set up by hand, Flyway makes it straightforward.

The build stage automatically checks whether the new code deploys, whether it rolls back, whether it follows our code analysis rules, and what impact it'll have.

It speeds up pull requests, removes bottlenecks, catches problems early, and makes releasing safer. Once the pull request is approved, a Flyway agent handles the deployment automatically, which removes another layer of manual risk, and another chance for the AI to cause harm.

If you want to see V2 running end-to-end — the AI committing to a feature branch, the build kicking off in GitHub Actions, the code analysis rules firing, and the Flyway agent deploying through to production — that's what the webinar covers, and I walk through the full setup in **Part 1 of the Agentic Workflows with Flyway mini-series** *(linked at the bottom)*.

## V3, going further

V2 is a big step up. It gives a clear audit of what the AI did, tests and builds everything in a sandbox, reports on impact, and uses GitHub policies to make sure changes are isolated and reviewed by a human before release. When I see a team reach this point I'm genuinely pleased, because plenty of teams are still taking real risks with AI and no safety net. Flyway and GitHub together make it barely any slower than the original, dangerous workflow.

There's still more we can do, though. Two things bother me about V2. First, I'd rather a deterministic engine wrote the actual migration scripts, not the AI, which can still hallucinate something we didn't test for. Second, if we're going to let AI do this much, the audit trail has to be airtight.

V3 fixes both:

- **Flyway Enterprise's compare engine generates the migration scripts, not the AI.** The AI edits the plain-SQL schema model, and Flyway turns those edits into deterministic versioned scripts. If it can't generate a valid migration, we know immediately that something the AI did wasn't safe — on a branch, where nothing else is affected.
- **The whole thing is wired up through a couple of small files.** An `agent.md` tells the AI what to do and when to call the Flyway CLI, and a `copilot-setup.yml` gives the agent a Flyway installation to work with. Together, they're how the AI knows to hand script generation to Flyway rather than writing migrations itself.
- **Reporting becomes airtight.** SOX, DORA, and GDPR all require safe processing and clear records, and that matters even more when AI is in the mix. Flyway generates a **change report** (exactly what will happen to the database) and a **drift report** (whether the target environment still looks the way it should) before every release. Cross-reference the two, and you've removed almost every category of risk.

The full setup is more than I can cover here, so if you want the detail, the webinar with the GitHub team walks through it, and **Parts 2 and 3 of the mini-series** take you through building it yourself — the `agent.md` and `copilot-setup.yml` in full, and the audit trail with drift and change reports.

## Summary

AI can unlock things we've never seen before, but it raises the need for DevOps, it doesn't replace it. Organizations have spent decades building, testing, and trusting their infrastructure. We need to move fast, but not at the cost of safety.

We can automate tests. We can enforce Git policies. We can use tools that turn non-deterministic, hallucinating AI into safe, auditable releases. So the real question is: why haven't you done this yet, and what's stopping you?

If you don't know where to begin, reach out to us at Redgate. We've been the leading provider of database DevOps tooling for over 20 years, and making releases safe is our bread and butter. AI doesn't scare us, and it shouldn't scare you. Let's remember where we came from and do this properly.

Look after yourself out there. Use AI wisely. And let the humans around you know they're valued.

— Huxley Kendell

---

### Want to build this yourself? — Agentic Workflows with Flyway

This mini-series assumes you already have a working Flyway Enterprise project (Flyway Autopilot or the Redgate University "Getting Started with Flyway" course will get you there in an afternoon). From there, four short posts turn it into an agentic project:

- **Part 1** — Configuring the agent's runtime: `copilot-setup-steps.yml` that installs Flyway, writes the licence, and spins up a shadow database for the agent.
- **Part 2** — Setting AI behaviour: `agent.md` scopes the AI to `schema-model/` and hands script generation to Flyway; `.mcp.json` wires the Flyway CLI up as callable MCP tools.
- **Part 3** — Repo policies and the PR build: branch protection on `main`, a Flyway build stage running on every pull request, SARIF findings surfaced on the PR.
- **Part 4** — The release: change and drift reports before every deploy, a GitHub Environment gate before Prod, artifacts retained for audit.
