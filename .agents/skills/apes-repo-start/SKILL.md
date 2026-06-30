---
name: apes-repo-start
description: Use at the start of APES CIC repository work to inspect guidance, branch state, working tree state, local tooling, and task scope before planning or implementation.
---

# APES Repo Start

Use this skill before planning or implementation in an APES CIC repository.

1. Read root `AGENTS.md` and `.agents/AGENTS.md`.
2. Confirm repository root, remote, current branch, default branch, and working
   tree state.
3. Check whether the branch is `main`, `master`, `production`, `staging`, a
   release branch, protected, shared, or long lived.
4. Search for relevant guidance: `README.md`, `CONTRIBUTING.md`,
   `INSTRUCTIONS.md`, `.codex/CODEX_ENVIRONMENT_SETUP.md`, package files,
   Composer files, Makefiles, CI files, and task-relevant source files.
5. Run `.codex/scripts/discover-local-dev-tools.ps1` when present.
6. Identify update type, website type, hosting target, public-folder impact,
   release-record impact, GitHub issue status, branch decision, validation
   path, and Codex browser preview requirement.
7. Do not edit files, create branches, stage, commit, push, deploy, install
   tools, or mutate Git state until the user has approved the required decision
   and plan.

Output a concise readiness summary with blockers and unresolved decisions.
