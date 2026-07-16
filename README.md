# Agent Skills

A curated engineering workflow for Codex, Claude Code, and other Agent Skills-compatible coding agents.

The bundle contains eleven composable skills for shaping an idea, documenting the domain, triaging requests, planning the work, implementing it test-first, validating it in Chrome, orchestrating subagents, and reviewing the result.

## Install

Install all eleven skills globally into both Codex and Claude Code:

```bash
npx skills@latest add fdarkaou/agent-skills \
  --skill '*' \
  --global \
  --agent codex \
  --agent claude-code \
  --yes
```

This is the recommended bundle install. The plain `npx skills add` command remains interactive by design, so the explicit flags are what make the complete bundle the default here.

To choose individual skills or another supported agent instead:

```bash
npx skills@latest add fdarkaou/agent-skills
```

## Invoke A Skill

Use the invocation style shown by your agent:

```text
Codex:      $implement Fix the billing regression
Claude Code: /implement Fix the billing regression
```

The skill instructions are universal. When an optional capability such as subagents or real-Chrome control is unavailable, the skill adapts honestly or reports the exact blocker instead of pretending the capability exists.

## Which Skill Should I Use?

| You want to… | Use |
|---|---|
| Build or fix production behavior test-first | [`implement`](#implement) |
| Build and prove the real user journey in Chrome | [`implement-with-validation`](#implement-with-validation) |
| Review a PR, branch, commit range, diff, or worktree | [`pr-code-review`](#pr-code-review) |
| Coordinate a main agent and specialized executors | [`orchestrate-models`](#orchestrate-models) |
| Stress-test an idea one decision at a time | [`grilling`](#grilling) |
| Define precise domain language and durable decisions | [`domain-modeling`](#domain-modeling) |
| Grill a plan while maintaining domain docs | [`grill-with-docs`](#grill-with-docs) |
| Configure issue tracking and domain-doc conventions | [`setup-matt-pocock-skills`](#setup-matt-pocock-skills) |
| Move incoming issues through a consistent triage state machine | [`triage`](#triage) |
| Turn an agreed conversation into a spec or PRD | [`to-spec`](#to-spec) |
| Break a spec into dependency-aware vertical tickets | [`to-tickets`](#to-tickets) |

## Build

### `implement`

[Source](./skills/fdarkaou/implement/SKILL.md)

Implements the smallest complete production slice through a public interface. Every behavior follows red → green → refactor, with no shims, duplicate truth, fallback paths, speculative code, or TODO debt.

- **Use when:** building features, fixing bugs, or changing behavior.
- **Invoke:** `$implement Build the account export flow` or `/implement Build the account export flow`.
- **Produces:** working code, behavior-focused tests, relevant quality-gate results, and an honest verification report.
- **Key distinction:** automated tests are the completion boundary. Use `implement-with-validation` when the browser journey must also pass.

### `implement-with-validation`

[Source](./skills/fdarkaou/implement-with-validation/SKILL.md)

Composes `implement` with real end-to-end validation in the user's existing Chrome session. It defines an acceptance matrix, starts the actual local application, and exercises every changed journey as a user.

- **Use when:** the change is browser-reachable and “done” must include the authenticated local experience.
- **Invoke:** `$implement-with-validation Fix onboarding and verify it locally`.
- **Produces:** automated-test evidence plus a journey-by-journey `VALIDATED` or `BLOCKED` report.
- **Requires:** a runtime integration that can drive the existing Chrome session. Codex can use `chrome:control-chrome`; Claude Code can use a configured Chrome/browser integration or MCP.
- **Safety:** never invents credentials, bypasses authentication, exposes environment values, or silently substitutes headless testing for the selected real session.

## Review

### `pr-code-review`

[Source](./skills/fdarkaou/pr-code-review/SKILL.md)

Performs a read-only, evidence-first review of a PR, branch, explicit Git range, diff, or requested work-in-progress changes. A PR is optional.

- **Use when:** deciding whether a change is correct, faithful to its spec, and maintainable.
- **Invoke:** `$pr-code-review https://github.com/acme/app/pull/42` or `/pr-code-review Compare this branch with main`.
- **Lenses:** standards and Fowler smells, correctness, spec fidelity, history, prior PRs, and code contracts.
- **Produces:** separate Correctness, Spec, and Design Signals sections. Actionable findings require independent validation and at least 80 confidence.
- **Requires:** at least one real independent subagent. With limited concurrency, specialist and validator roles run sequentially; with none, the skill reports `BLOCKED`.
- **Safety:** does not edit, fix, publish, approve, request changes, or merge unless separately authorized.

## Orchestrate

### `orchestrate-models`

[Source](./skills/fdarkaou/orchestrate-models/SKILL.md)

Keeps one coordinator responsible for design, integration, verification, and the final answer while bounded subagents handle routine or deep executor work.

- **Use when:** investigation, implementation, or review benefits from parallel or specialized agents.
- **Invoke:** `$orchestrate-models Investigate and fix this cross-service failure`.
- **Portable roles:** coordinator, routine executor, and deep executor.
- **Codex adapter:** prefer Sol as coordinator, Luna for routine execution, and Terra for ambiguous or high-risk execution when explicit selectors exist.
- **Claude Code adapter:** use the main session as coordinator and native subagents as executors. Report models as inherited or unknown when no selector exists.
- **Produces:** bounded delegations with explicit scope and an independently verified integrated result.

## Discover And Decide

### `grilling`

[Source](./skills/matt/grilling/SKILL.md)

Interviews you one decision at a time until the plan, idea, or trade-off is genuinely understood. It recommends an answer for each branch and researches facts instead of asking you to supply them.

- **Use when:** an idea is fuzzy, assumptions need pressure-testing, or you want the agent to challenge the plan.
- **Invoke:** `$grilling Stress-test this subscription design`.
- **Produces:** shared understanding and explicit decisions. It does not act until you confirm alignment.

### `domain-modeling`

[Source](./skills/matt/domain-modeling/SKILL.md)

Builds the project's ubiquitous language. It challenges overloaded terms, checks the code against stated rules, updates `CONTEXT.md`, and records only genuinely durable trade-offs as ADRs.

- **Use when:** naming is inconsistent, domain boundaries are unclear, or a lasting architecture decision needs context.
- **Invoke:** `$domain-modeling Clarify Account, Workspace, Member, and Seat`.
- **Produces:** a precise glossary and, when justified, focused architecture decision records.

### `grill-with-docs`

[Source](./skills/matt/grill-with-docs/SKILL.md)

Combines `grilling` with `domain-modeling`. Decisions are challenged interactively while accepted terminology and durable trade-offs are captured in the repository.

- **Use when:** a feature or architecture plan needs both alignment and lasting documentation.
- **Invoke:** `$grill-with-docs Challenge the multi-tenant billing plan`.
- **Produces:** shared decisions, updated domain language, and justified ADRs.
- **Depends on:** `grilling` and `domain-modeling`, both included in this bundle.

## Plan And Decompose

### `setup-matt-pocock-skills`

[Source](./skills/matt/setup-matt-pocock-skills/SKILL.md)

Configures a repository so the planning skills know where issues live, which triage labels to use, and where domain context and ADRs belong.

- **Use when:** first installing this workflow in a repository or changing its issue tracker or documentation layout.
- **Invoke once per repository:** `$setup-matt-pocock-skills`.
- **Produces:** an `Agent skills` instruction block plus focused files under `docs/agents/`.
- **Supports:** GitHub, GitLab, local Markdown, and user-described trackers such as Jira or Linear.

### `triage`

[Source](./skills/matt/triage/SKILL.md)

Moves issues and external PRs through a small state machine. It categorizes the request, verifies the claim, gathers missing information, and writes a durable brief when the work is ready for an agent or human.

- **Use when:** reviewing an incoming issue, deciding what needs attention, or moving work between `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, and `wontfix`.
- **Invoke:** `$triage Show me what needs attention` or `$triage Move #42 to ready-for-agent`.
- **Produces:** verified issue state, consistent labels, AI-disclosed tracker comments, and agent-ready briefs.
- **Depends on:** the label mapping created by `setup-matt-pocock-skills`; it can call `grilling` and `domain-modeling` when a request needs clarification.

### `to-spec`

[Source](./skills/matt/to-spec/SKILL.md)

Synthesizes the current conversation and codebase understanding into a publishable specification. It does not repeat discovery questions that were already resolved.

- **Use when:** the problem, solution, and important decisions are understood and need a durable implementation contract.
- **Invoke:** `$to-spec Turn our decisions into a PRD`.
- **Produces:** problem and solution, extensive user stories, implementation and testing decisions, scope boundaries, and a tracker-ready spec.
- **Naming:** this is the current upstream replacement for the older `to-prd` skill.

### `to-tickets`

[Source](./skills/matt/to-tickets/SKILL.md)

Breaks a conversation, plan, or spec into thin tracer-bullet tickets. Each ticket delivers a complete vertical behavior and declares the tickets that block it.

- **Use when:** an approved spec needs independently grabbable implementation work.
- **Invoke:** `$to-tickets Break spec #123 into implementation tickets`.
- **Produces:** approved vertical slices in the configured tracker, ordered by dependency frontier and labeled ready for an agent.
- **Naming:** this is the current upstream replacement for the older `to-issues` skill.

## Recommended Workflows

### From Idea To Validated Feature

```text
setup-matt-pocock-skills   Run once per repository
          ↓
triage                     Verify and shape incoming requests when needed
          ↓
grill-with-docs            Resolve decisions and domain language
          ↓
to-spec                    Publish the agreed contract
          ↓
to-tickets                 Create vertical, dependency-aware work
          ↓
orchestrate-models         Route bounded work when delegation helps
          ↓
implement-with-validation  Build test-first and prove the Chrome journey
          ↓
pr-code-review             Review correctness, spec fidelity, and design
```

### Direct Bug Fix

Use `implement` for a backend or library fix. Use `implement-with-validation` when the defect is observable through a browser journey and that journey is part of the completion bar.

### Review Without A Pull Request

Give `pr-code-review` a branch, base/head pair, Git range, or explicit WIP-only target. If a branch has no PR, the skill asks which base to compare rather than silently assuming `main`.

## Runtime Capabilities

All eleven skills install into Codex and Claude Code. Installation makes the workflow available; the active runtime still determines which execution surfaces exist.

| Capability | Behavior |
|---|---|
| Subagents and model selectors | `orchestrate-models` uses native capabilities and can work inline. `pr-code-review` requires at least one independent subagent and reports `BLOCKED` when none exists. |
| Existing-session Chrome control | `implement-with-validation` uses a configured real-Chrome integration. Without one, it reports `BLOCKED`. |
| GitHub CLI | PR metadata, prior-PR research, publication, and GitHub issue creation require an authenticated `gh` CLI. Local review still works without publication. |
| Issue tracker configuration | Run `setup-matt-pocock-skills` once so `triage`, `to-spec`, and `to-tickets` share tracker and label conventions. |

## Update Installed Skills

After this repository changes, update globally installed skills with:

```bash
npx skills@latest update --global --yes
```

The installer records the source repository, so teammates receive the latest merged bundle.

## Update Matt Pocock's Skills In This Repository

Selected skills are vendored from [mattpocock/skills](https://github.com/mattpocock/skills). They do not drift automatically into this repository without review.

From GitHub:

1. Open **Actions**.
2. Select **Sync Matt Pocock skills**.
3. Click **Run workflow**.
4. Review the generated pull request.
5. Merge it when the prompt and supporting-file changes look correct.

From the GitHub CLI:

```bash
gh workflow run sync-matt-skills.yml --repo fdarkaou/agent-skills
```

The workflow also runs every Monday. It copies complete selected directories, records the exact upstream commit, avoids duplicate/no-op PRs, and never auto-merges prompt changes.

For a local sync:

```bash
git clone https://github.com/fdarkaou/agent-skills.git
cd agent-skills
./scripts/sync-matt-skills.sh
./scripts/validate-skills.sh
git diff
```

## Bundle Policy

- Fekri's skills live under [`skills/fdarkaou/`](./skills/fdarkaou/).
- Selected Matt Pocock skills live under [`skills/matt/`](./skills/matt/).
- Matt-derived directories are copied completely, including supporting files and agent metadata.
- [`upstream/matt-pocock.commit`](./upstream/matt-pocock.commit) records the vendored source commit.
- [`upstream/MATT-POCOCK-LICENSE`](./upstream/MATT-POCOCK-LICENSE) preserves Matt Pocock's MIT license.
- Separate `tdd` and `nodebt` skills are omitted because `implement` already combines their core test-first and end-state-quality contracts.
- Upstream prompt changes require human review before reaching teammates.

## Validate The Bundle

```bash
./scripts/validate-skills.sh
```

The validator checks the expected eleven-skill catalog, required frontmatter, unique names, supporting files, and recorded upstream provenance.

## License

Fekri's original skills and repository code are available under the [MIT License](./LICENSE). Matt-derived skills retain Matt Pocock's MIT license and attribution in [THIRD_PARTY_NOTICES.md](./THIRD_PARTY_NOTICES.md).
