# Product Surfaces & Operations

Settings, menu bar, sound, power, performance, accessibility.

# **25. Sound**

Do **not** include sound in V1.

Later:

* ambient rain  
* city noise  
* ocean  
* subtle drones  
* optional instrumental music

But audio should default to:

**OFF**

The desktop shouldn't randomly start playing music and scare the hell out of someone during a meeting.

---

# **26. Power & Performance**

This is a critical product requirement.

The application must not turn an M4 MacBook into a space heater.

Targets:

### **Static mode**

Negligible CPU.

### **Video mode**

Use hardware decoding.

### **Idle mode**

Optimize aggressively.

### **Battery**

Automatically reduce/disable animation.

Potential policy:

AC power  
→ full experience

Battery  
→ reduced frame rate / pause video

Low Power Mode  
→ static background \+ poetry only

LiveWall already demonstrates battery-aware pausing as a useful precedent.

---

# **27. Performance Targets**

Initial targets:

| Metric | Target |
| ----- | ----- |
| Idle CPU | \<2% |
| Static poetry CPU | \~0–1% |
| Video playback | hardware accelerated |
| Memory | \<150 MB target |
| Startup | \<2 sec target |
| Animation | 60 FPS where feasible |
| Battery impact | minimal |

These are **engineering targets**, not guarantees; measure them on real hardware.

---

# **28. Accessibility**

Support:

* Reduce Motion  
* Increase Contrast  
* Dynamic Type where practical  
* VoiceOver-compatible settings  
* adjustable text size  
* adjustable opacity  
* adjustable display duration

If macOS Reduce Motion is enabled:

fade  
↓  
simple crossfade

rather than elaborate movement.

---

# **29. Settings**

Eventually:

General  
├── Launch at Login  
├── Show in Menu Bar  
└── Start Automatically

Poetry  
├── Font  
├── Size  
├── Position  
├── Alignment  
├── Animation  
└── Timing

Background  
├── Video  
├── Static Image  
├── Brightness  
└── Blur

Performance  
├── Battery Mode  
├── FPS  
└── Pause When Covered

Behavior  
├── Start After Idle  
├── Pause When Active  
└── Continue From Previous Position  
---

# **30. Menu Bar App**

The application should eventually live primarily in the menu bar.

Something like:

☼ Ambient Poetry

Currently playing  
"If—"  
Rudyard Kipling

──────────────

Pause  
Next stanza  
Restart poem

──────────────

Poems  
Backgrounds  
Settings

──────────────

Quit

The app should not need a permanent Dock presence.

---
