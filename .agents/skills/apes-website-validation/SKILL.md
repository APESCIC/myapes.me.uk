---
name: apes-website-validation
description: Use for APES CIC website, app, route, public-folder, Cloudron LAMP, PHP, MySQL, SEO, sitemap, footer, Newsroom, or visual validation work.
---

# APES Website Validation

Use this skill when the task affects a browser-served website, application,
route, public folder, PHP endpoint, MySQL-backed flow, Cloudron LAMP behavior,
SEO, sitemap, footer, Newsroom, or error page.

Validation checklist:

1. Read `.agents/AGENTS.md` and `.codex/CODEX_ENVIRONMENT_SETUP.md`.
2. Confirm website type and hosting target.
3. Confirm `public/` is the browser-served root unless repository evidence or
   approved scope says otherwise.
4. Run the repository-approved local validation command, or record the exact
   blocker.
5. For PHP files in scope, run `php -l` when PHP is available.
6. For Node projects, prefer documented `npm run lint`, `typecheck`, `test`,
   `test:e2e`, and `build` scripts where present.
7. Start local preview only when approved and safe.
8. Inspect affected routes in the Codex browser and record local URL, route
   notes, screenshot status, and console or visible errors.
9. Check mobile usability when visual changes are in scope.
10. Confirm no stack traces, debug output, private URLs, credentials, or
    environment values are exposed.
11. Check SEO, sitemap, canonical URLs, robots/noindex, navigation, footer,
    Change Log Hub links, Newsroom routing, and error pages where relevant.
12. Record Cloudron LAMP compatibility, UK GDPR implications, release records,
    and unresolved blockers.

If preview cannot run, state the exact blocked-preview reason and do not imply
visual validation passed.
