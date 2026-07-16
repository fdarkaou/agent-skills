# Universal Skill Catalog Design

## Goal

Make the repository understandable and installable as one universal workflow bundle for Codex and Claude Code. Include every dependency needed for the advertised planning workflow.

## Portability Contract

Every skill describes a capability, not one agent product. Agent-specific adapters are allowed only where the underlying surface differs.

- `implement-with-validation` requires a browser-control capability that can drive the user's real Chrome session. Codex may satisfy it with `chrome:control-chrome`; Claude Code may satisfy it with an installed Chrome/browser integration or MCP. If none is available, validation is `BLOCKED`.
- `orchestrate-models` uses portable coordinator, routine-executor, and deep-executor roles. Codex maps those roles to Sol, Luna, and Terra when available. Other agents use their native subagents and available model selectors without inventing capabilities.
- `pr-code-review` reports in the current agent session and uses whichever independent subagent surface is available.
- The remaining skills already express agent-independent engineering workflows.

## README Structure

1. Outcome-led introduction and universal install command.
2. A decision table answering which skill to invoke.
3. A grouped catalog for Build, Review, Orchestrate, Discover, Triage, and Plan.
4. For each skill: purpose, when to use it, example invocation, prerequisites, and output.
5. End-to-end workflow recipes showing how skills compose.
6. Runtime capability notes for browser control, subagents, GitHub, and issue trackers.
7. Installed-skill updates, upstream Matt syncs, bundle policy, licensing, and validation.

The README explains behavior without duplicating full skill prompts.

## Installation

The primary command installs all eleven skills globally into both Codex and Claude Code. Interactive and single-agent alternatives remain available. The bundle includes `triage` so setup always creates the labels used by `to-spec` and `to-tickets`.
