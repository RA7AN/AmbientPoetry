# Locked Tech Stack — Ambient Poetry

**Status:** Locked for V0.x through GitHub Beta  
**Last reviewed:** 2026-09-20  
**Change policy:** Do not swap the stack casually. If you believe a change is required, update this file with justification *before* introducing the dependency or rewrite.

---

## Decision summary

Ambient Poetry is a **native macOS** ambient literary layer. The PRD’s recommendation stands:

| Layer | Choice | Role |
|-------|--------|------|
| Language | **Swift 6** | All app code |
| UI | **SwiftUI** | Poetry rendering, settings, menu bar (`MenuBarExtra`) |
| Desktop integration | **AppKit** | Borderless desktop-level `NSWindow`, click-through |
| Motion | **SwiftUI animations + Core Animation** | Restrained fades / drifts / line reveals |
| Video (later) | **AVFoundation** | Looping live backgrounds — **V0.4+, not V0.3** |
| Packaging | **Xcode macOS app** | `.app` bundle, resources, login item |
| License | **MIT** | Application code |
| Target | **Apple Silicon, macOS 15+** | First-class; Intel not prioritized |

Root pointer: also see [TECH_STACK.md](../TECH_STACK.md) at repository root.

---

## Why this stack (do not replace without cause)

1. **Desktop window level** — Real wallpaper-adjacent behavior needs `NSWindow` levels relative to desktop icons. Electron/Tauri/Flutter fight this and waste the product’s energy on chrome.
2. **Typography** — Literary type is the product. Native text layout and font metrics matter more than cross-platform convenience.
3. **Power & offline-first** — No Chromium runtime; no accounts or network required for the core loop.
4. **Iteration speed on Mac** — SwiftUI + a thin AppKit desktop shell is enough for rapid visual iteration through V0.3–V1.0.
5. **Upstream groundwork** — OpenLiveWalls / LiveWall / Aerial already proved desktop video and wallpaper patterns in Swift; we reuse *patterns*, not a web shell.

### Explicitly rejected for core app

| Option | Why rejected |
|--------|----------------|
| Electron / Tauri | Wrong window model, battery, typography |
| Flutter / Kotlin Multiplatform | Extra abstraction for a Mac-only ambient layer |
| Python / scripting hosts | Not suitable for always-on desktop UI |
| Private Wallpaper Extension APIs as foundation | Fragile; keep behind abstractions in V0.9+ only |

---

## Allowed dependencies (V0.3)

Prefer **zero** dependencies. Approved small deps:

| Package | Use | Notes |
|---------|-----|-------|
| [sindresorhus/LaunchAtLogin](https://github.com/sindresorhus/LaunchAtLogin) | Open at login | Or `SMAppService` (macOS 13+) if the package is unnecessary |
| System frameworks only | Everything else | SwiftUI, AppKit, Foundation, Combine / Observation |

### Reference repositories (patterns only — not required packages)

- [OpenLiveWalls](https://github.com/openlivewalls/OpenLiveWalls) — desktop-level video / window patterns
- LiveWall-style borderless desktop windows
- [Aerial](https://github.com/JohnCoates/Aerial) — later wallpaper extension research (V0.9)

Do not vendor large wallpaper apps into this repo. Adapt the minimal window-level approach yourself.

---

## Architecture lock: Experience

All features hang off an **Experience** (not “wallpaper” or “quote widget”):

```
Experience
├── Poetry (text, author, stanza timeline)
├── Background (image now; video later)
├── Typography (font, size, layout region)
├── Animation (entrance, hold, exit / style)
└── Behavior (idle later; pause/resume; login)
```

Content stays in **JSON** under the app bundle (`Resources/Poems` in the repo). Adding a poem must not require Swift changes.

---

## Milestone ↔ technology gates

| Milestone | Stack additions allowed |
|-----------|-------------------------|
| V0.1–V0.3 (this seed) | SwiftUI, AppKit desktop window, JSON poems, LaunchAtLogin / SMAppService |
| V0.4 | AVFoundation for looping video backgrounds |
| V0.5 | Idle detection (AppKit event monitors / I/O Kit as needed) |
| V0.6+ | Timeline sync; still no Electron |
| V0.9 | Wallpaper Extension / screensaver — abstract; private APIs not the core |

---

## Content licensing (not code)

- Bundled poem *If—* (Rudyard Kipling): treat as **public domain** for US distribution; verify before App Store if that path is taken.
- Bundled background image: must be owned by the project or clearly licensed for redistribution. Document provenance in `Resources/Backgrounds/ATTRIBUTION.md`.

---

## When to revisit this document

Re-open the stack decision only if:

- Apple ships a public Wallpaper API that replaces desktop-level windows, or
- A platform expansion (iOS/iPad) is explicitly added to the roadmap, or
- Measured performance cannot meet targets in [08-surfaces-and-ops.md](08-surfaces-and-ops.md) with the current approach.

Any change requires updating this file, [06-roadmap.md](06-roadmap.md), and the root README in the same PR.
