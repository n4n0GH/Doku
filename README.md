# Kirigami Design Guide

A documentation website that brings the KDE Human Interface Guidelines, the Kirigami tutorial and the Kirigami API
together in one place, written in plain language, with a real screenshot for every rule and component.

Unofficial; not affiliated with or endorsed by KDE e.V.

## Working on the site

```sh
npm install
npm run dev        # live preview at http://localhost:4321 (search is not available in dev)
npm run build      # static site in dist/, including the search index
npm run preview    # serve dist/
```

Requires Node 22.23 or newer.

## How it fits together

| Path | What it holds |
| --- | --- |
| `src/content/docs/<section>/<page>.mdx` | One guide page each. Frontmatter sets title, summary, section, order and upstream sources. |
| `examples/**/*.qml` | One small QML file per picture. It is both the source of the screenshot and the code sample shown to readers. |
| `public/renders/` | The screenshots, light and dark, generated from the examples. Committed, so CI does not need Kirigami. |
| `src/data/theme-*.json` | Real `Kirigami.Units` and `Kirigami.Theme` values, read from the installed Kirigami. Used by the swatch and unit tables. |
| `src/components/` | Building blocks for pages: `Example`, `DoDont`/`Do`/`Dont`, `Callout`, `Swatches`, `UnitScale`. |
| `tools/render/` | The screenshot pipeline. |

## Screenshots

```sh
npm run render             # render examples that changed
npm run render -- --force  # render everything
npm run render -- card     # only examples whose path contains "card"
```

This runs each example with `qml6` on Qt's offscreen platform, once with Breeze Light and once with Breeze Dark,
and saves a 2x PNG. It needs, installed locally: Qt 6 (`qml6`), Kirigami, qqc2-desktop-style, the Plasma platform
theme (plasma-integration), the Breeze icon themes and colour schemes, the Noto Sans and Hack fonts, and working
OpenGL.

Two kinds of example:

- `name.qml` has an ordinary item as its root and is rendered at its own size with a little padding.
- `name.mobile.window.qml` is a window example rendered in Kirigami's phone mode.
- `examples/tutorial/stepN.window.qml` are the complete apps for each tutorial step. The `shot-*` files next to
  them are copies with different starting data, used only for screenshots; regenerate them when a step changes.
- `name.window.qml` has a `Kirigami.ApplicationWindow` as its root. The whole window is captured, including open
  dialogs and drawers.

## Adding a page

1. Write the QML examples the page needs in `examples/` and run `npm run render`.
2. Create `src/content/docs/<section>/<page>.mdx`. Copy the frontmatter and imports from an existing page.
3. Show an example with `<Example name="components/my-example" alt="…" caption="…" />`. Add `markers` to put
   numbered callouts on the screenshot (positions are percentages of its width and height).
4. Follow the page order used throughout: what it is, when to use it, how to use it well, in code, properties.
5. List the upstream pages you worked from under `sources`.

Link to other pages with root-relative paths such as `/foundations/colour/`; the base path is added for you.

## Licence

The repository carries two licences.

**Content**: the guide pages in `src/content/` and the screenshots in `public/renders/`. The text is adapted from
the [KDE Human Interface Guidelines](https://develop.kde.org/hig/) and Kirigami documentation, © The KDE Community,
licensed CC BY-SA 4.0, and is shared under the same licence. The full text is in [LICENSE-CONTENT](LICENSE-CONTENT).

**Code**: everything else, including the site source, the components, the render tool and the QML examples, is
Copyright © 2026 n4n0 and is free software under the GNU General Public License, version 3 or (at your option) any later version. The full text
is in [LICENSE](LICENSE).
