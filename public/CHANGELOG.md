# Changelog

All notable public-facing MyAPES changes are recorded here.

## v3.1.1b - 2026-07-01

Status: Beta

Change type: Patch

Summary: Migrated production metadata to `myapes.me.uk`, aligned SEO canonical/sitemap/OG references, and added public deployment guidance for `/public` with Cloudron + JetBrains workflows.

Detailed changes:

- Updated all public page canonical URLs from the prior beta domain to `myapes.me.uk` (including homepage OG URL).
- Updated `public/sitemap.xml` and `public/robots.txt` with production domain.
- Updated template README canonical example to the production domain.
- Added Cloudron hosting and local preview documentation in `README.md`.
- Updated public release records and version file (`v3.1.1b`).

Affected areas:

- SEO/metadata
- Deployment documentation
- Change Log Hub and version records
- Cloudron/JB workflow guidance

Version decision:

- Patch beta production-readiness release, version `v3.1.1b`.

Validation:

- `php -l public/template/layout.php`
- `rg -n "https://beta\\.apes\\.me\\.uk" public`
- `php -S 127.0.0.1:8080 -t public` route checks (`/`, `/support/`, `/sitemap.xml`, `/does-not-exist`)

## v3.1.0b - 2026-06-30

Status: Beta

Change type: Minor beta update

Summary: Updated MyAPES into a public resource and tool hub, added the Fun Zone menu, added public tool cards for CareBase, APES Social, Discord, Contact Centre, Feedback and APES Tube, and clarified the separation between MyAPES public resources and MyAPES Account private service user tools.

Detailed changes:

- Updated the homepage hero, calls to action and public/private portal messaging.
- Added `/resource-hub/`, `/fun-zone/`, `/support/` and `/account/` public routes.
- Added Fun Zone cards for APES CareBase, APES Social, APES Discord, APES Contact Centre, APES Feedback and APES Tube.
- Updated shared public navigation, mobile navigation, footer links and external link indicators.
- Updated sitemap, smoke-test coverage, version records and Change Log Hub release metadata.

Affected areas:

- Public-facing navigation
- Resource Hub
- Fun Zone
- Support signposting
- Accessibility
- Public/private portal separation

Version decision:

- Minor beta public-facing update, version `v3.1.0b`.

Validation planned:

- `npm run validate`
- `npm run smoke`
- HTTP preview at `http://127.0.0.1:8080/`
- Direct `file:///` homepage check
- Desktop and mobile browser checks
- Manual external link checks for Contact Centre, Feedback and Discord before launch

## v3.0.1b - 2026-06-18

Status: Beta

Change type: Patch

Summary: Completed the public-only cleanup by removing legacy private-entry and redirect surfaces, pruning unused runtime folders, and aligning scripts and documentation to the active static website scope.

Detailed changes:

- Removed legacy private-entry and transition route folders from `public/`.
- Updated smoke and public-root validation scripts to validate only active public website routes and files.
- Removed unused private-runtime stylesheet blocks from the shared stylesheet.
- Updated repository documentation and release records to reflect a public-only website scope.

Affected areas:

- Public route surface
- Preview and validation workflow
- Public release records

Version decision:

- Patch beta cleanup release, version `v3.0.1b`.

Validation:

- `npm run validate`
- `npm run smoke`

## Earlier releases

Earlier release history is retained in the root changelog at `CHANGELOG.md`.
