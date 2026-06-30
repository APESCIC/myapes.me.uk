# myapes.me.uk

## Runtime and deployment target

MyAPES public site is delivered as a **static HTML/CSS/JS website served from `public/`**.

- Primary web root: `C:\Users\bmurp\PhpstormProjects\myapes.me.uk\public`
- Public routes are static files (`index.html` and folder `index.html` pages).
- `.htaccess` in `public/` keeps clean URLs and fallback 404 behavior for Apache.
- No private application runtime is required for the public site in this repository snapshot.

## Cloudron LAMP notes

The expected deployment target is the existing Cloudron LAMP pattern:

- Linux + Apache + PHP 8.3/8.4
- Document root set to `<app_root>/public`
- URL handling managed by `public/.htaccess`
- No custom Cloudron manifest was added in this change (platform-side app config is expected to already exist).
- No MySQL-backed runtime behavior is required for the public front door.

## Local preview and validation workflow

Run from repository root:

```powershell
php -S 127.0.0.1:8080 -t public
```

Then open:

- `http://127.0.0.1:8080/`
- `http://127.0.0.1:8080/support/`
- `http://127.0.0.1:8080/sitemap.xml`
- `http://127.0.0.1:8080/does-not-exist` (should resolve to branded 404)

### Codex/browser checks

For UI/route checks, validate the above paths in the Codex browser before handoff and record any blocker.

### Quick smoke checks

- `rg -n "https://beta\.apes\.me\.uk" public` (should return no results after domain migration)
- `php -l public/template/layout.php`

## JetBrains setup notes

For PHP/HTML editing in JetBrains IDEs:

- Open repository root as the project root.
- Set project PHP SDK to a PHP 8.3+ interpreter.
- Keep project files and shared run configs inside `.idea` (only existing tracked entries are expected for this repo).
- Ensure preview and static-path workflows reference `public/` as the web server docroot.

## Release records

- Public release records: `public/CHANGELOG.md`
- Change log hub page: `public/change-log-hub/index.html`
- Site version: `public/VERSION`

## Notes

External service links, account links and production credentials are intentionally kept out of this repository scope.
