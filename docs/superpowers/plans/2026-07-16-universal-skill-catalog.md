# Universal Skill Catalog Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Publish a clear README and portable custom-skill contracts for one complete Codex and Claude Code bundle.

**Architecture:** Keep universal behavior in each custom `SKILL.md`, with short runtime adapters for browser control and model routing. Rebuild the README around selection, catalog, composition, capabilities, installation, and maintenance.

**Tech Stack:** Markdown agent skills, Codex UI metadata, Vercel Skills CLI, Bash validation.

## Global Constraints

- Install all eleven skills into both Codex and Claude Code by default.
- Do not claim a browser or model selector exists when the active runtime does not expose it.
- Preserve the real-Chrome validation gate and honest `BLOCKED` outcome.
- Preserve Sol/Luna/Terra as the preferred Codex routing adapter.
- Do not modify Matt-derived skill content.
- Include Matt's `triage` skill so setup configures the labels required by `to-spec` and `to-tickets`.

---

### Task 1: Prove the current portability and documentation gaps

**Files:**
- Test: `README.md`
- Test: `skills/fdarkaou/implement-with-validation/SKILL.md`
- Test: `skills/fdarkaou/orchestrate-models/SKILL.md`

- [ ] Run a Claude Code browser-capability scenario against the current validation skill.
- [ ] Run a Claude Code native-subagent scenario against the current orchestration skill.
- [ ] Ask a fresh reader to select and compose the complete bundle from the current README.
- [ ] Record exact incompatibilities and missing explanations.

### Task 2: Make custom contracts capability-first

**Files:**
- Modify: `skills/fdarkaou/implement-with-validation/SKILL.md`
- Modify: `skills/fdarkaou/implement-with-validation/agents/openai.yaml`
- Modify: `skills/fdarkaou/orchestrate-models/SKILL.md`
- Modify: `skills/fdarkaou/orchestrate-models/agents/openai.yaml`
- Modify: `skills/fdarkaou/pr-code-review/SKILL.md`

- [ ] Replace the required Codex Chrome identifier with a portable real-Chrome capability and explicit runtime adapters.
- [ ] Express orchestration as portable roles, retaining the Sol/Luna/Terra Codex mapping.
- [ ] Replace Codex-only reporting language in PR review with current-session language.
- [ ] Regenerate UI metadata and validate each modified custom skill.
- [ ] Re-run the portability scenarios and require compliant outcomes.

### Task 3: Rebuild and publish the README

**Files:**
- Modify: `README.md`

- [ ] Lead with one all-skills, both-agents installation command.
- [ ] Add the skill selector, eleven detailed catalog entries, composition recipes, and capability requirements.
- [ ] Preserve update, Matt sync, policy, license, and validation instructions.
- [ ] Verify every command against current Vercel Skills CLI syntax and every catalog claim against its source skill.
- [ ] Run bundle validation and Markdown hygiene checks.
- [ ] Install changed custom skills locally, commit, push, and verify the published README.

### Task 4: Close the planning dependency graph

**Files:**
- Create: `skills/matt/triage/`
- Modify: `scripts/sync-matt-skills.sh`
- Modify: `scripts/validate-skills.sh`

- [ ] Vendor the complete upstream `triage` directory and supporting files.
- [ ] Add `triage` to the deterministic Matt sync mapping.
- [ ] Raise the expected bundle count to eleven and validate triage supporting files.
- [ ] Document triage, its label-state machine, and its place in the workflow.
