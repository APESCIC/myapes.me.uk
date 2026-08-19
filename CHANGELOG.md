# Changelog

This changelog records repository, continuous-integration and hosting changes
for the MyAPES Website. Public-facing release details are maintained separately
in [`public/CHANGELOG.md`](public/CHANGELOG.md) and presented through the
[Change Log Hub](https://myapes.me.uk/change-log-hub/).

## v3.2.2b - 2026-08-19

Status: Beta

Change type: Patch

Summary: Updated public contact details on the MyAPES website and added
client-side protection so the public email is not harvestable from page source.

Repository changes:

- Added root `VERSION` aligned with the public website patch `v3.2.2b`.
- Documented the postal address and new telephone in `README.md`, and pointed
  readers to the Contact page for the protected public email.

Public site changes:

- See [`public/CHANGELOG.md`](public/CHANGELOG.md) for the public contact,
  footer, harvest-protection and sitemap details.

Release records:

- Repository version: `v3.2.2b`.
- Public version and history: [`public/VERSION`](public/VERSION) and
  [`public/CHANGELOG.md`](public/CHANGELOG.md).

Validation:

- `php -l public/template/layout.php`
- Source assertions for the new address and telephone, absence of the old 0300
  number, and absence of a concatenated public email in `public/`
- Local preview of `/contact/`, `/` and `/privacy/`

## v3.2.0b - 2026-07-01

Status: Beta

Change type: Minor beta update

Summary: Public website theme, support routing and version records for
`v3.2.0b` are recorded in [`public/CHANGELOG.md`](public/CHANGELOG.md).
