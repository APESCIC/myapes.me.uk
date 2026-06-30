---
name: apes-codex-plan
description: Use when preparing an APES CIC implementation plan (Codex or
JetBrains-assisted) that must include issue, branch, validation, release,
Cloudron, public-folder, and GitHub handoff decisions.
---

# APES Codex Plan

Use this skill to produce a decision-complete plan before implementation, for both
Codex and JetBrains-assisted work.

Required structure:

```text
Issue decision:
Branch decision:
Current repository and branch:
Working tree state:
Update type:
Website type:
Hosting target:
Local execution environment:
Local validation status:
Route preview (Codex browser or equivalent):
Environment notes:
Files likely to change:
Implementation plan:
Work update plan:
Risks:
Validation:
Questions before implementation:
```

The plan must record:

- protected/shared branch status
- default base branch `main`
- `codex/<short-description>` branch naming
- scope and non-scope
- private configuration and no-secrets protections
- README, changelog, version, Change Log Hub, and generated-output impact
- public-folder, SEO, sitemap, footer, Newsroom, and error-page impact where
  relevant
- Cloudron LAMP and hosting assumptions where relevant
- GitHub issue and pull request expectations
- validation commands and route-preview evidence (Codex browser or equivalent) or
  blocker
- merge, cleanup, and issue-closure expectations

Do not implement inside this skill. End with the specific decisions or
questions needed before work can begin.
