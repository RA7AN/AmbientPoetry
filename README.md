# Ambient Poetry

A macOS menu bar app that turns your desktop into a quiet cinematic literary layer: a static ambient background with carefully animated poetry.

> Your desktop doesn't have to demand your attention. It can occasionally give something back.

**Current milestone:** **v0.3 — Desktop Mode**  
Native Swift app · JSON poetry engine · three animation styles · click-through desktop window · pause/resume · launch at login.

## Requirements

- macOS 15+
- Apple Silicon recommended
- Xcode 16+ (to build)

## Quick start

```bash
git clone git@github.com:RA7AN/AmbientPoetry.git
cd AmbientPoetry
# If you edit project.yml:
#   brew install xcodegen && xcodegen generate
open AmbientPoetry.xcodeproj
```

In Xcode: select the **AmbientPoetry** scheme → Run.

The app appears as a menu bar item (quote icon). Poetry plays on a **click-through** layer at the desktop wallpaper level so the desktop stays usable.

### Menu bar

- **Pause / Resume**
- **Animation** — Cinematic Fade, Progressive Lines, Stanza Reveal
- **Settings…** — timing, typography, poem, launch at login
- **Quit**

## Adding a poem (no Swift changes)

1. Add a JSON file under [`Resources/Poems/`](Resources/Poems/).
2. Rebuild the Xcode project (`xcodegen generate` if you changed `project.yml`, then build).
3. Pick it in Settings → Poem.

Example shape:

```json
{
  "id": "my-poem",
  "title": "Title",
  "author": "Author",
  "stanzas": [
    {
      "lines": ["line one", "line two"],
      "displayDuration": 12
    }
  ]
}
```

Bundled sample: *If—* by Rudyard Kipling (public domain in the US). See content notes in [docs/07-content-system.md](docs/07-content-system.md).

## Project layout

```
AmbientPoetry/          App sources (App, Desktop, Experience, Engine, Views)
Resources/              Poems + backgrounds (copied into the app bundle)
docs/                   Split PRD + locked TECH_STACK
project.yml             XcodeGen project definition
```

## Documentation (locked path)

| Doc | Purpose |
|-----|---------|
| [docs/INDEX.md](docs/INDEX.md) | Doc map |
| [docs/TECH_STACK.md](docs/TECH_STACK.md) | **Locked** tech stack — read before changing architecture |
| [docs/06-roadmap.md](docs/06-roadmap.md) | V0.1 → V1.0 roadmap |
| [PRD-Ambient-Poetry.md](PRD-Ambient-Poetry.md) | Pointer into the split docs |

Do not swap the native Swift stack for Electron/Tauri/etc. without updating `docs/TECH_STACK.md` first.

## Roadmap (next)

- **V0.4** — Video backgrounds (AVFoundation)
- **V0.5** — Idle-aware activation
- **V0.6+** — Synchronised compositions, custom content, multi-display polish

## License

MIT — see [LICENSE](LICENSE).

Poem texts and background assets may have separate provenance; see `Resources/Backgrounds/ATTRIBUTION.md` and the content docs.
