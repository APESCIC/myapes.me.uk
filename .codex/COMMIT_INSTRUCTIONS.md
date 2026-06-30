# APES CIC Commit Instructions

Use these instructions only after the user explicitly approves a state-changing
Git action.

## Before Staging

1. Confirm the active repository and branch.
2. Confirm the branch is not `main`, `master`, `production`, `staging`, a
   release branch, protected, shared, or long lived unless the user explicitly
   approved that branch for the task.
3. Run `git status --short --branch`.
4. Review the diff and confirm changes are inside the approved scope.
5. Confirm no secrets, private configuration, local dumps, generated
   credentials, or private data are included.
6. Confirm validation status and record any blockers.

## Staging

- Do not run `git add .`.
- Stage files by explicit path or logical group.
- Do not stage unrelated changes.
- If unexpected user changes appear, leave them untouched and ask only if they
  block the approved work.

## Commit Message

Use concise messages that explain the purpose:

```text
docs: add APES Codex agents template
chore: refresh Codex template manifest
fix: correct APES validation script
```

## After Commit

Report:

- commit SHA
- changed file groups
- validation run
- release-record status
- issue or PR update status where relevant
- push status
- next recommended GitHub step
