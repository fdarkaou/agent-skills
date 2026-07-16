---
name: implement
description: Implements production behavior through test-first vertical slices with no technical debt, bridges, compatibility shims, fallback paths, or split truth. Use when the user asks to implement, build, fix, or change behavior, or when they want TDD/no-debt development.
---

# Implement

## Principle
Ship the smallest complete vertical slice through the correct public interface and canonical owner.

Every behavior change follows red -> green -> refactor. Green means the test passes and the implementation has no debt: no bridges, compatibility shims, fallback paths, split truth, TODO-driven hacks, or misleading partial types.

If the full feature cannot ship cleanly in one pass, narrow scope. Do not paper over the gap.

## Before Coding
Answer these before editing implementation code:

- What public interface proves the behavior?
- What behavior should be tested first?
- What is the canonical owner for this behavior?
- What stable contract should callers use?
- What is the smallest complete vertical slice?
- What shortcut would be tempting here, and why is it rejected?
- What verification will prove the slice works?

Confirm interface and behavior priorities with the user when meaningful product choices are open. Otherwise, proceed from existing code, tests, docs, or issue context.

## Test Standard
Tests verify behavior through public interfaces, not implementation details. Good tests exercise real code paths through public APIs and describe what the system does. Bad tests mock internal collaborators, test private methods, or verify through external means instead of using the interface.

Use the project's domain glossary so test names, public interfaces, and implementation vocabulary match product language. Respect relevant ADRs before changing governed decisions.

## Horizontal Slice Anti-Pattern
Do not write all tests first, then all implementation. That treats red as "write all tests" and green as "write all code."

Wrong:

- RED: test1, test2, test3
- GREEN: impl1, impl2, impl3

Right:

- RED -> GREEN: test1 -> impl1
- RED -> GREEN: test2 -> impl2
- RED -> GREEN: test3 -> impl3

## Loop

### RED: One Failing Test
Write one test for one observable behavior.

- Test through the public interface only.
- Do not test private methods or internal structure.
- Do not mock internal collaborators.
- Mock only true boundaries: network providers, queues, clocks, payment gateways, external APIs.
- Name the test using domain vocabulary.
- Confirm the test fails for the expected reason.

### GREEN: Smallest Correct Slice
Write the smallest production implementation that makes the current failing test pass.

Green does not mean "the test passes at any cost." Green means:

- Behavior passes through the public interface.
- Behavior lives in the canonical owning layer.
- Implementation uses the stable contract for that owner.
- No split truth, shadow implementation, or duplicate source of behavior.
- No transport bridge, legacy-to-new mapper, compatibility layer, fallback path, or feature-flagged duplicate logic.
- No TODO-driven hack, silent retry that hides bugs, or partial type that misrepresents behavior.
- No speculative code beyond the current test's behavior.

If the behavior cannot be implemented cleanly in one pass, narrow scope to the smallest complete vertical slice.

### Repeat
For each remaining behavior, write the next behavior test, confirm it fails, implement the smallest correct slice, and confirm it passes.

One test at a time. Only enough code to pass the current test. Keep tests focused on observable behavior and keep implementation in the canonical owner.

### REFACTOR: Improve While Green
Only refactor after tests pass. Look for duplicated behavior, shallow modules, misplaced ownership, unclear names, obsolete compatibility code, tests coupled to implementation, and contracts that expose too much implementation detail.

After each meaningful refactor, rerun the targeted test.

## Per-Cycle Checklist
- Test describes behavior, not implementation.
- Test uses the public interface only.
- Test failed before implementation.
- Code is minimal for this test.
- Behavior lives in the canonical owner.
- Stable contract is used or introduced.
- No speculative feature was added.
- No bridge, shim, fallback, or shadow path was added.
- No TODO debt or misleading partial type was added.
- Targeted test passes.

## Closeout
Run relevant tests and typecheck/lint when warranted by the touched area. Remove obsolete paths when the slice replaces them. In the final response, report what was verified and anything not verified.

Follow repository agent rules such as AGENTS.md when present. If repo guidance conflicts with this skill, use the stricter implementation-quality rule.
