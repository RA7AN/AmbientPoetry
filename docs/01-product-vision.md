# Product Vision

Locked product intent for Ambient Poetry. Prefer this over improvising features.

# **1. Product Summary**

**Ambient Poetry** is a macOS application that transforms the desktop into a quiet, cinematic literary experience.

Instead of displaying a static inspirational quote, the application presents:

> **beautiful moving environments \+ carefully animated poetry**

Poems unfold gradually, stanza by stanza, while an ambient background—initially a static image and eventually an Aerial-style video—provides a continuously changing visual environment.

The goal is not to make the desktop distracting.

The goal is to make the user occasionally stop and read it.

### **Product thesis**

> **Your desktop doesn't have to demand your attention. It can occasionally give something back.**

---

# **2. The Core Experience**

The ideal experience looks like this:

                   USER IS WORKING  
                          │  
                          │  
                    desktop is normal  
                          │  
                          ▼  
                    user becomes idle  
                          │  
                          ▼  
              ambient scene begins moving  
                          │  
                          ▼  
                 poetry begins appearing  
                          │  
                          ▼  
               stanza 1 → stanza 2 → stanza 3  
                          │  
                          ▼  
                    user returns  
                          │  
                          ▼  
             experience gracefully pauses

The poetry and background should feel like **one composition**, rather than two widgets placed on top of each other.

---

# **3. The Problem**

Modern computer desktops are optimized for:

* productivity  
* notifications  
* information density  
* entertainment  
* advertisements  
* visual customization

There is very little designed specifically for:

* reflection  
* inspiration  
* literature  
* calm  
* ambient beauty  
* intentional pauses

Existing wallpaper applications largely focus on:

> “Make my desktop move.”

Existing quote applications largely focus on:

> “Show me a quote.”

Existing screensavers focus on:

> “Show me something beautiful while I'm away.”

Ambient Poetry combines the three:

> **Show me something beautiful, and give me something worth reading.**

---

# **5. Target User**

## **Primary user**

A Mac user who:

* cares about aesthetics  
* likes literature/poetry  
* enjoys ambient experiences  
* spends significant time at their computer  
* wants their desktop to feel personal  
* dislikes intrusive productivity software

Potential audiences include:

* developers  
* designers  
* writers  
* students  
* researchers  
* creatives  
* academics  
* knowledge workers

---


# **43. Final Product Vision**

The end state I would aim for is **not**:

> “A Mac app that displays inspirational quotes.”

It is:

> **A cinematic ambient layer for your computer, where literature unfolds slowly over living environments.**

The ideal user doesn't constantly interact with it.

They install it once.

They choose a mood.

Then they occasionally look up from their work and see:

> *If you can keep your head*  
>  *when all about you*  
>  *are losing theirs*  
>  *and blaming it on you...*

And then they go back to work.

**That's the product.**

And technically, the timing is actually pretty good for building it: current open-source projects have already done much of the nasty macOS wallpaper groundwork, including desktop-level video playback, lock-screen experimentation, and—through Aerial—modern Wallpaper Extension work. That means we can spend our engineering effort on the part that isn't commoditized: **the poetry engine, composition system, typography, and overall experience.**

### **Suggested first milestone**

I'd make the very first repository **deliberately tiny**:

`ambient-poetry-v0.1`

One SwiftUI window, one city image, *If—*, three animation styles, and a tiny settings panel. **No live wallpaper yet.**

If that prototype looks good enough that you genuinely want to leave it running, *then* we build the wallpaper engine underneath it. That's the highest-information, lowest-waste path to the GitHub beta described above.
