---
name: apes-github-handoff
description: Use when preparing APES CIC branch completion, changed-file summaries, validation handoff, commit readiness, push readiness, pull request text, or issue updates.
---

# APES GitHub Handoff

Use this skill after implementation or review when preparing GitHub-facing
handoff notes.

Before any state-changing Git or GitHub action, confirm explicit user approval.
Do not stage, commit, push, open a pull request, merge, delete branches, enable
auto-merge, or close issues without approval.

Handoff summary must include:

- progress summary
- changed files with short explanations
- checks run and blockers
- README, changelog, version, Change Log Hub, and generated-output status
- public-folder and local validation status
- Codex browser preview status, inspected URL, or blocked-preview reason
- website type, Cloudron LAMP, and hosting status where relevant
- GitHub issue status
- SEO, sitemap, footer, Newsroom, and error-page status where relevant
- branch name, base branch, push status, merge status, and sync status
- risks and follow-up work
- next recommended GitHub step

If preparing PR text, use `.github/pull_request_template.md` and include the
issue number or no-issue reason.
