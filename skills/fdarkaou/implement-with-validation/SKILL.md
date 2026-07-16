---
name: implement-with-validation
description: Use when implementing or fixing browser-reachable product behavior that must be proven end to end in the user's real local Chrome session before completion.
---

# Implement With Validation

## Contract

Browser-facing work is complete only when automated gates pass and every changed user journey passes in the real local application through the user's existing Chrome session.

**REQUIRED SUB-SKILL:** Use `implement` for test-first vertical slices and no-debt implementation.

**REQUIRED BROWSER SKILL:** Use `chrome:control-chrome`. Follow its browser-selection, authentication, and no-fallback rules exactly.

If the requested behavior has no browser-reachable journey, use `implement` instead.

## Before Coding

Create a browser acceptance matrix from the requirements:

| Behavior | Preconditions | User actions | Expected visible result |
|---|---|---|---|
| One changed journey per row | Required account/data/state | Exact clicks and inputs | Observable product outcome |

Include the happy path and changed error, permission, loading, empty, persistence, navigation, or responsive behavior. For a bug, reproduce it in Chrome first when the runtime is available.

## Implementation Loop

Follow `implement` for each vertical slice. Once a slice is browser-reachable, exercise its acceptance rows in Chrome. Fix deterministic browser failures through another failing automated test.

Browser checks complement automated tests; neither substitutes for the other.

## Local Runtime Preflight

1. Read repository instructions for install, environment, database, and dev server.
2. Identify required variable names without displaying values.
3. In a worktree, use `git worktree list --porcelain` to locate the primary checkout. If this worktree lacks an environment file and a matching gitignored file exists there, ask before reusing it. Never print, commit, or expose its contents.
4. Use the documented bootstrap mechanism. Never invent placeholder secrets.
5. Start the real application on an available port, wait for readiness, and record the exact origin.
6. Connect to the existing Chrome session and navigate to that origin.

## Authentication

Use only the normal login flow or a documented, sanctioned test account. If Chrome reaches login and no supported automated login exists, ask the user to sign in there and tell you when it is ready.

Never:

- inspect cookies, storage, passwords, or session internals;
- create a temporary auth bypass or undocumented test account;
- inject fabricated tokens or credentials;
- replace Chrome with headless Chrome, Playwright, another browser, API calls, or mocks;
- treat a logged-out page as proof of the authenticated journey.

## Browser Validation

Execute every acceptance row as a user. Verify visible results and relevant console or network failures. Recheck persistence after reload. Exercise relevant viewport states for responsive changes.

Record evidence:

| Journey | Result | Evidence |
|---|---|---|
| Requirement or acceptance row | PASS or BLOCKED | Route, actions, observed result, and relevant error |

Do not use a screenshot alone as proof of interaction or persistence.

## Terminal Outcomes

### VALIDATED

Use only when automated gates and every Chrome acceptance row pass. Report commands, journeys, and observed outcomes.

### BLOCKED

Use when environment, services, Chrome, authentication, or test data prevents a row. Report the exact blocker, what passed, and one next action. Do not call the implementation complete or fully validated.

## Rationalizations To Reject

| Rationalization | Contract |
|---|---|
| "Automated tests passed" | They do not prove routing, rendering, auth, or browser integration. |
| "The user did not repeat the Chrome requirement" | Invoking this skill is the requirement. |
| "The worktree has no environment file" | Repair setup safely or report BLOCKED. |
| "Headless validation is equivalent" | It does not prove the user's selected Chrome session. |
| "Implementation is complete; validation is pending" | Under this skill, completion includes validation. |
