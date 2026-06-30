# APES CIC Pull, Push, and Pull Request Instructions

Use these instructions only after the user explicitly approves the relevant Git
or GitHub action.

## Pull and Sync

Before pulling or rebasing:

1. Confirm repository, current branch, and working tree state.
2. Confirm the target base branch.
3. Do not rebase, reset, stash, or discard changes without explicit approval.
4. If local changes exist, summarize them and ask for the approved sync path.

## Push

Before pushing:

1. Confirm branch name and upstream target.
2. Confirm the branch is an approved task branch.
3. Confirm validation status and known blockers.
4. Do not force push unless the user explicitly approves force push for this
   branch and reason.

## Pull Request

Pull request bodies must include:

- summary
- scope and non-scope
- issue link or no-issue reason
- update type and website type
- changed files or routes
- validation run and blockers
- README/changelog/version/Change Log Hub status
- public-folder, SEO, sitemap, footer, Newsroom, and error-page status where
  relevant
- Cloudron LAMP and hosting impact where relevant
- release impact
- follow-up work

Open draft PRs unless the user asks for a ready-for-review PR.

## Merge and Cleanup

Do not merge, enable auto-merge, delete branches, or close issues without
explicit approval. After merge or safe abandonment, ask for branch cleanup and
issue closure decisions.
