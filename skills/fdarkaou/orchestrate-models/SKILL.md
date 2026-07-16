---
name: orchestrate-models
description: Use when starting a Codex session that may delegate investigation, implementation, or review work across GPT-5.6 Sol, Luna, or Terra.
---

# Orchestrate Models

Keep `gpt-5.6-sol` in the main loop for product, UX/UI, architecture, API, and implementation design; orchestration; integration; and final review. Route executor work explicitly.

## Session-start routing

1. Inspect the displayed delegation schema before dispatching.
2. Sol completes the design and writes an executor-ready specification before delegation. Executors may gather evidence; Sol decides.
3. Use `gpt-5.6-luna` for routine reconnaissance, mechanical edits, tests, and clear-spec implementation.
4. Use `gpt-5.6-terra` for ambiguous debugging, cross-boundary/high-risk implementation, or a failed Luna attempt—not design ownership.
5. Give each executor a bounded slice with exact scope, exclusions, output, and verification.
6. Sol inspects the actual result, integrates it, reruns checks, and owns final review.
7. Report every delegation with model, scope, and routing reason.

## Model selection

- Treat the current tool schema as ground truth; never invent a model field.
- Prefer an explicit model selector when the delegation surface provides one.
- When it does not, inherited/default-model in-app subagents are allowed. Report the model as inherited or unknown rather than claiming Luna or Terra.
- Use an explicit executor command such as `codex exec --ephemeral -m gpt-5.6-luna ...` or `-m gpt-5.6-terra ...` only when CLI delegation is useful for the task.
- Prompting an inherited agent to “act as Luna” does not change its model.
- Parallelize only independent slices with non-overlapping write ownership.

## App and CLI surfaces

- If the app Worker schema has no model selector, it cannot guarantee Luna/Terra; use it when inherited/default-model delegation is appropriate and describe the routing honestly.
- Explicitly selected Luna/Terra can run through `codex exec -m ...`; these appear as CLI/background processes, not app Workers.
- Child CLI sessions may require Full Access or a scoped approval for Codex state, private-repo, process, or network access. If blocked, do not bypass the runtime; ask for the required access or work inline on Sol.

## Red flags

- Invented model selector
- Misreporting an inherited/default model as an explicitly selected model
- Executor-owned product, UX/UI, architecture, API, or implementation design
- Overlapping executor edits
- Unverified summary or test claim
