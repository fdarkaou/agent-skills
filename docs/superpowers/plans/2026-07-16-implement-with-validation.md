# Implement With Validation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add and publish a compositional skill that requires real Chrome acceptance testing before browser-facing implementation can be called complete.

**Architecture:** `implement-with-validation` delegates code-quality behavior to `implement` and owns only acceptance planning, local-runtime preflight, Chrome execution, blocker handling, and evidence-backed closeout. The bundle validator and README make the new skill discoverable and communicate its Chrome prerequisite.

**Tech Stack:** Markdown agent skills, Codex `agents/openai.yaml`, Bash bundle validation, Vercel Skills repository layout, Chrome plugin.

## Global Constraints

- Keep `implement` unchanged.
- Use the user's existing Chrome session through `chrome:control-chrome`.
- Never bypass authentication, expose secrets, or silently replace Chrome with another browser.
- Browser-facing work is complete only with `VALIDATED`; unmet prerequisites produce `BLOCKED`.
- Preserve Matt-derived skill directories and upstream provenance unchanged.

---

### Task 1: Establish the failing behavioral baseline

**Files:**
- Create: none
- Modify: none
- Test: three fresh-agent pressure scenarios

**Interfaces:**
- Consumes: approved design and the existing `implement` and Chrome contracts
- Produces: observed omissions and rationalizations that the skill must correct

- [ ] **Step 1: Run a deadline-pressure scenario where automated tests pass but Chrome validation remains.**
- [ ] **Step 2: Run a worktree scenario with missing environment and secrets in the primary checkout.**
- [ ] **Step 3: Run an authenticated-flow scenario where Chrome is logged out.**
- [ ] **Step 4: Record which agents skip proof, choose unsafe credential handling, substitute tools, or overclaim completion.**

### Task 2: Author the minimum compositional skill

**Files:**
- Create: `skills/fdarkaou/implement-with-validation/SKILL.md`
- Create: `skills/fdarkaou/implement-with-validation/agents/openai.yaml`
- Test: skill-creator validator and fresh-agent pressure scenarios

**Interfaces:**
- Consumes: `$implement` and `Chrome:control-chrome`
- Produces: `VALIDATED` or `BLOCKED` with an acceptance-evidence table

- [ ] **Step 1: Write frontmatter whose trigger is browser-reachable implementation requiring real local acceptance proof.**
- [ ] **Step 2: Add the acceptance matrix, runtime preflight, Chrome validation loop, blocker rules, and closeout contract.**
- [ ] **Step 3: Generate Codex UI metadata with a default prompt that explicitly invokes `$implement-with-validation`.**
- [ ] **Step 4: Run the skill validator and confirm the skill is structurally valid.**
- [ ] **Step 5: Re-run the baseline scenarios with the candidate skill and verify convergence on its contract.**

### Task 3: Publish and install the validated skill

**Files:**
- Modify: `README.md`
- Modify: `scripts/validate-skills.sh`
- Create: local installed `~/.codex/skills/implement-with-validation/`

**Interfaces:**
- Consumes: validated candidate skill
- Produces: a ten-skill public bundle and matching local installation

- [ ] **Step 1: Add the skill and Chrome prerequisite to the README.**
- [ ] **Step 2: Update the expected bundle count and names from nine to ten.**
- [ ] **Step 3: Run Bash syntax, bundle validation, YAML parsing, skill validation, and deterministic upstream-sync checks.**
- [ ] **Step 4: Install the exact validated directory into the local Codex skills directory.**
- [ ] **Step 5: Commit `feat: add browser-validated implementation skill`.**
- [ ] **Step 6: Push `main` and verify the public repository contains the skill.**
