# MyAPES Template System

This folder contains the shared branded template system for MyAPES public routes.

## Goals

- Keep APES branding consistent across all template-enabled pages.
- Centralize shared layout sections so pages do not duplicate header and footer markup.
- Preserve accessibility and navigation behavior already used by `public/assets/js/site.js`.

## Files

- `layout.php`: shared rendering functions for head, header, navigation, footer, and page shell.

## Page usage

A template-enabled page should:

1. `require_once` this folder's `layout.php`.
2. Define page metadata (`title`, `description`, `canonical`, `robots`).
3. Define `currentPath` so active navigation links are rendered correctly.
4. Call `template_render_page_start($page)`.
5. Output route-specific `<section>` content.
6. Call `template_render_page_end()`.

Example:

```php
<?php
require_once __DIR__ . '/../template/layout.php';

$page = [
    'title' => 'Example | MyAPES',
    'description' => 'Example route description.',
    'canonical' => 'https://myapes.me.uk/example/',
    'robots' => 'index, follow',
    'currentPath' => '/example/'
];

template_render_page_start($page);
?>
<section class="wrap section-shell">
  <h1>Example page</h1>
</section>
<?php template_render_page_end(); ?>
```

## Branding compliance

The template uses existing APES brand assets and tokens:

- Site CSS: `public/assets/css/site.css`
- Shared JS navigation behavior: `public/assets/js/site.js`
- Logo asset: `/assets/apes-logo-navbar-72h-C6PH2zPj.png`

Do not replace colors, typography, spacing, or brand copy in shared template output unless branding guidance is updated.

