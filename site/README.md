# Portfolio site (Jaspr)

The portfolio rebuilt with [Jaspr](https://jaspr.site) in static mode. Every page is pre-rendered to plain HTML at
build time, so it shows instantly and needs no Flutter engine.

- `lib/data/` – the same skills, technologies and Rive art data as the Flutter app.
- `lib/pages/` – the home page and the skills playground.
- `web/styles.css` – all styling, including the mobile layout.
- `web/main.js` – small enhancements: dialogs, header scroll-spy and lazy Rive loading.
- `web/playground.js` – the skills playground: a small physics world with five modes (bubbles, magnets,
  constellations, ball pit and breakout), loaded only on that page.

Build: `dart pub global activate jaspr_cli && jaspr build` (output in `build/jaspr`). CI does this on every PR and
deploys `main` to GitHub Pages.
