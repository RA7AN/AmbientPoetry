# Content System

Poems, backgrounds, authoring format, and future custom/AI content.

# **21. Content System**

Eventually the application should have a content library.

Poems  
├── Poetry  
├── Philosophy  
├── Literature  
├── Speeches  
├── Wisdom  
└── User

Each content item:

Title  
Author  
Text  
Language  
License  
Source  
Animation metadata  
Recommended background  
Mood  
Duration  
---

# **22. Custom Poems**

A major future feature:

> **Paste your own writing.**

Example:

\+ Add poem

Title:  
Author:

Paste text:  
────────────────────  
...  
────────────────────

The application automatically detects:

* stanzas  
* lines  
* paragraph boundaries

and generates a basic animation timeline.

---

# **23. AI-Assisted Composition**

This should be **very far down the roadmap**, not the core product.

Potential future functionality:

> “Make this poem feel like a quiet winter morning.”

AI could recommend:

* background  
* typography  
* stanza timing  
* animation style  
* color treatment

Or:

> “Create a 3-minute ambient visual treatment for this poem.”

AI generates a **composition plan**, not necessarily the actual media.

---

# **24. Background Library**

Eventually:

CITY  
├── Tokyo  
├── New York  
├── London  
├── Dubai  
└── Riyadh

NATURE  
├── Ocean  
├── Mountains  
├── Forest  
└── Desert

ABSTRACT  
├── Light  
├── Clouds  
└── Geometry

But the initial open-source project should probably ship with **very few assets**.

Why?

Copyright and repository size.

The app can support user-provided videos instead.

---

# **31. Content Authoring Format**

I strongly recommend creating an internal format.

Example:

title: If—  
author: Rudyard Kipling

animation:  
  style: progressive  
  defaultDuration: 12

stanzas:

  \- lines:  
      \- "If you can keep your head"  
      \- "when all about you"  
      \- "are losing theirs"  
      \- "and blaming it on you,"  
      
    timing:  
      reveal: 1.2  
      hold: 6  
      exit: 1

background:  
  mood: dawn  
  motion: slow

This makes the engine extremely extensible.

Eventually creators could submit **poetry packs**.

---
