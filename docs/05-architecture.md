# Architecture

Core technical design for poetry, animation, typography, and the Experience abstraction.

# **9. V1 Technical Architecture**

               Ambient Poetry  
                       │  
              ┌────────┴────────┐  
              │                 │  
         Poetry Engine      Background  
              │                 │  
              │              Static  
              │                image  
              ▼                 │  
        Animation Engine        │  
              │                 │  
              └────────┬────────┘  
                       ▼  
                 SwiftUI View  
                       │  
                       ▼  
               Borderless Window

### **Technology**

**Swift**

Primary language.

**SwiftUI**

Application UI and poetry rendering.

**AppKit**

Desktop-level window behavior.

**Core Animation**

Precise animation and transitions where SwiftUI isn't sufficient.

**AVFoundation**

Reserved for V2 when video backgrounds arrive.

---

# **10. Poetry Data Model**

Poetry should not be hardcoded into views.

Something like:

struct Poem {  
    let title: String  
    let author: String  
    let stanzas: \[Stanza\]  
}

struct Stanza {  
    let lines: \[String\]  
    let duration: TimeInterval  
}

Eventually:

{  
  "title": "If—",  
  "author": "Rudyard Kipling",  
  "stanzas": \[  
    {  
      "lines": \[  
        "If you can keep your head",  
        "when all about you",  
        "are losing theirs",  
        "and blaming it on you,"  
      \],  
      "displayDuration": 12  
    }  
  \]  
}

This is important because it makes the animation engine independent of the actual literature.

---

# **11. Poetry Animation Engine**

The engine should operate on a timeline.

STANZA  
   │  
   ├── entrance  
   │  
   ├── line reveal  
   │  
   ├── hold  
   │  
   ├── optional emphasis  
   │  
   └── exit

For example:

0.0s   stanza begins  
0.8s   line 1  
2.0s   line 2  
3.2s   line 3  
4.4s   line 4  
8.0s   hold  
12.0s  fade out  
13.0s  transition

The exact timings should eventually be data-driven rather than embedded in animation code.

---

# **12. Animation Styles**

The application should eventually have a **visual language** rather than a single animation.

### **Style 1 — Fade**

Minimal.

### **Style 2 — Drift**

Text slowly moves 5–15 px while appearing.

### **Style 3 — Progressive**

Lines appear sequentially.

### **Style 4 — Type**

Subtle typewriter-style reveal.

Use sparingly.

### **Style 5 — Focus**

Important words become slightly more prominent.

### **Style 6 — Cinematic**

Whole stanza moves through a carefully choreographed composition.

---

# **13. Typography**

This deserves disproportionate attention.

Possible typography directions:

### **Literary**

Serif font.

Elegant.

Book-like.

### **Editorial**

High-contrast serif.

Large type.

Very few elements.

### **Modern**

Sans-serif.

Minimal.

Apple-like.

### **Monospace**

Potentially beautiful for technical/philosophical writing but probably not default.

---

# **14. Layout System**

Rather than hardcoding:

center everything

the system should support layout regions.

┌───────────────────────────────┐  
│                               │  
│         TOP                   │  
│                               │  
│                               │  
│       CENTER                  │  
│                               │  
│                               │  
│              LOWER           │  
│                               │  
└───────────────────────────────┘

Potential placements:

* center  
* lower center  
* lower left  
* upper left  
* right aligned  
* editorial asymmetric  
* cinematic full-width

But the default should be **center/lower-center**.

---

# **42. One Architectural Decision I'd Make Now**

I'd make the entire project revolve around a concept called an **Experience**.

Not “wallpaper.”

Not “poem.”

An Experience is:

Experience  
│  
├── Poetry  
│     ├── text  
│     ├── author  
│     └── timeline  
│  
├── Background  
│     ├── image/video  
│     └── playback  
│  
├── Typography  
│     ├── font  
│     ├── size  
│     └── layout  
│  
├── Animation  
│     ├── entrance  
│     ├── hold  
│     └── exit  
│  
└── Behavior  
      ├── idle trigger  
      ├── duration  
      └── resume policy

That abstraction gives you a huge amount of runway.

Today:

> **If— \+ city image**

Tomorrow:

> **If— \+ aerial city video**

Later:

> **your poem \+ generated environment \+ synchronized camera movement**

And eventually:

> **a complete cinematic literary experience.**

---
