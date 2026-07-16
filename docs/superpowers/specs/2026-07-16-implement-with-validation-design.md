# Implement With Validation Design

## Goal

Provide an explicit implementation workflow whose definition of done includes test-first, no-debt code and successful end-to-end validation through the user's real Chrome session.

## Boundary

Create a separate `implement-with-validation` skill. It composes the existing `implement` skill rather than changing it. Use it for behavior with a browser-reachable user journey; use ordinary `implement` for libraries, CLIs, migrations, or backend behavior with no browser surface.

## Workflow

1. Invoke `implement` for its red-green-refactor and end-state-quality contract.
2. Translate the requested behavior into a small browser acceptance matrix before implementation.
3. Reproduce an existing defect in Chrome when applicable.
4. Implement vertical slices with automated tests first.
5. Start the real local application and validate each changed journey with `chrome:control-chrome` in the user's existing Chrome session.
6. Check visible behavior and relevant console or network failures. Cover the happy path, changed error paths, persistence/reload, navigation, and responsive states when the change affects them.
7. Report one of two terminal outcomes: `VALIDATED` or `BLOCKED`. Never substitute automated tests for the requested browser proof.

## Environment And Authentication

- Discover the repository's documented setup and required variable names without printing values.
- In a worktree, locate the primary checkout and identify a matching gitignored environment file. Ask before linking or copying it; never expose its contents.
- Never invent placeholder secrets, add an authentication bypass, or create undocumented test credentials.
- Use a documented test account when one exists.
- When the selected Chrome session is logged out, ask the user to sign in there and continue when they confirm readiness.
- Do not switch to headless Chrome, Playwright, another browser, or mocks when Chrome was explicitly selected.
- Missing environment, unavailable dependencies, failed browser connection, or unavailable authentication is a blocker, not successful validation.

## Distribution

Add the skill to `fdarkaou/agent-skills`, document the Chrome plugin prerequisite, update bundle validation from nine to ten skills, install the same validated copy locally, and publish the repository update.
