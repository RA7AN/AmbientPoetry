# Roadmap

Version plan and recommended development order. **Do not skip ahead** of the locked path without updating this doc and `TECH_STACK.md`.

Current ship target for this repository seed: **through V0.3**.

# **15. V2 — Real Desktop Wallpaper**

Once the V1 experience feels good, move the renderer behind desktop icons.

Use a desktop-level `NSWindow` approach initially.

This is well-established: LiveWall, for example, uses a borderless window at the desktop window level with `AVPlayerLooper`.

Architecture:

                Desktop  
                    │  
       ┌────────────┴─────────────┐  
       │                          │  
   Video Layer              Poetry Layer  
       │                          │  
       └────────────┬─────────────┘  
                    │  
             Desktop Window  
                    │  
              Finder Icons

The user should be able to continue using the Mac normally.

---

# **16. V3 — Live Backgrounds**

Introduce video.

Initial support:

* MP4  
* MOV  
* H.264  
* HEVC

AVFoundation should handle playback and hardware decoding where supported.

The first test should be a **10–30 second loop**, not a massive 4K/240fps cinematic asset.

Performance first.

---

# **17. V4 — Synchronised Ambient Experience**

Now the two timelines become related.

Video timeline  
       │  
       ├───────────────┐  
       │               │  
       ▼               ▼  
   Scene A          Scene B  
       │               │  
       ▼               ▼  
  Stanza 1          Stanza 2

For example:

### **Scene**

Sunrise.

### **Poem**

> If you can keep your head...

Then:

### **Scene**

City beginning to wake.

### **Poem**

> If you can trust yourself...

The video becomes part of the storytelling.

---

# **18. V5 — Idle-Aware Experience**

This is where the original Apple-style idea comes into play.

Normal operation:

User active  
    ↓  
Static wallpaper

After inactivity:

Idle  
 ↓  
Video starts  
 ↓  
Poetry begins

After user returns:

User returns  
 ↓  
Freeze / transition  
 ↓  
Static desktop

The exact macOS lifecycle behavior needs to be tested rather than assumed.

---

# **19. V6 — Lock Screen / Aerial Integration**

Eventually investigate native macOS wallpaper/screen-saver integration.

However, this should **not be a V1 architectural dependency**.

Aerial's current implementation is instructive here: its native Wallpaper Extension relies on Apple's private, undocumented API.

Therefore:

### **Preferred strategy**

Core Experience  
      │  
      ▼  
public macOS APIs  
      │  
      ▼  
desktop wallpaper

Optional advanced integration:

macOS-specific adapter  
        │  
        ▼  
Aerial / Wallpaper Extension

This isolates future breakage.

---

# **20. Multi-Monitor Support**

Eventually:

Monitor 1  
   │  
   └── poem \+ background

Monitor 2  
   │  
   └── different scene / same poem

Potential modes:

### **Mirror**

Same experience everywhere.

### **Independent**

Different poem/background per monitor.

### **Cinematic**

One scene spans displays.

### **Primary-only**

Poetry appears only on the primary monitor.

The default should probably be **primary display only** initially.

---

# **33. Version Plan**

This is the most important part of the PRD.

I would **not** try to jump directly to the polished live-wallpaper product.

Instead:

---

## **V0.1 — Animation Laboratory**

**Goal:** Prove the poetry experience.

### **Features**

* SwiftUI app  
* static background  
* one poem  
* 3 animation styles  
* configurable timing  
* typography experimentation

### **Deliverable**

A developer can run:

git clone ...  
open AmbientPoetry.xcodeproj

and see the experience.

### **Success criterion**

You personally look at it for several minutes and think:

> “I want this on my desktop.”

If not, stop and improve the visual language.

---

# **V0.2 — Poetry Engine**

Separate the content from presentation.

### **Add**

* JSON/YAML poem format  
* multiple stanzas  
* poem switching  
* reusable animation engine  
* author metadata  
* automatic stanza sequencing

### **Goal**

Adding a new poem should require **no Swift code changes**.

---

# **V0.3 — Desktop Mode**

Now make it an actual wallpaper.

### **Add**

* borderless desktop-level window  
* menu bar application  
* static background  
* animated poetry  
* pause/resume  
* launch at login

### **Goal**

Use it for an entire work session.

---

# **V0.4 — Video Backgrounds**

Add:

* AVFoundation  
* MP4/MOV  
* looping  
* video controls  
* hardware decoding  
* dimming  
* video scaling

### **Goal**

moving background  
        \+  
animated poem

This is the first **true product prototype**.

---

# **V0.5 — Idle Mode**

Add:

* inactivity detection  
* automatic activation  
* pause when user returns  
* configurable idle timeout  
* battery awareness

Experience:

work  
 ↓  
idle  
 ↓  
ambient experience  
 ↓  
return  
 ↓  
desktop  
---

# **V0.6 — Cinematic Synchronisation**

Introduce timeline-based compositions.

Example:

00:00 background begins  
00:04 line 1  
00:07 line 2  
00:11 stanza completes

00:17 camera begins moving  
00:21 stanza 2  
...

This is where the project becomes genuinely distinctive.

---

# **V0.7 — Custom Content**

Add:

* import poem  
* import image  
* import video  
* create composition  
* save compositions

Potential UI:

Create Experience

Poem  
\[ If— \]

Background  
\[ City at Dawn \]

Animation  
\[ Cinematic \]

Duration  
\[ 03:20 \]

             Preview  
---

# **V0.8 — Multi-Display \+ Performance**

Before calling anything “beta”:

* multi-monitor  
* battery optimization  
* performance profiling  
* memory leaks  
* sleep/wake testing  
* Spaces testing  
* Mission Control testing  
* fullscreen application behavior  
* display disconnect/reconnect  
* external monitor testing

This is boring engineering.

It is also the difference between:

> “Cool GitHub project”

and

> “I actually use this every day.”

---

# **V0.9 — macOS Integration**

Investigate:

* native Wallpaper Extension  
* screensaver integration  
* lock-screen continuity  
* Aerial-compatible approaches

Keep these behind an abstraction.

Do **not** make private APIs the foundation.

Aerial's current architecture is a useful reference precisely because this area of macOS is complicated and Apple doesn't expose everything as a public API.

---

# **V1.0 — GitHub Beta**

This should be the **first release I'd actually announce publicly**.

## **Core experience**

✅ Native macOS application  
 ✅ Beautiful animated poetry  
 ✅ Static backgrounds  
 ✅ Video backgrounds  
 ✅ Idle activation  
 ✅ Menu bar controls  
 ✅ Custom poems  
 ✅ Custom backgrounds  
 ✅ Multiple animation styles  
 ✅ Performance controls  
 ✅ Battery-aware behavior  
 ✅ Multi-display support  
 ✅ Good documentation  
 ✅ Tests  
 ✅ Crash/error handling  
 ✅ Clean repository  
 ✅ Demo video  
 ✅ Screenshots

### **Example:**

Ambient Poetry 1.0 Beta

Your desktop, but quieter.

        \[animated city\]

       If you can keep your head  
       when all about you  
       are losing theirs  
       and blaming it on you,

                  — Rudyard Kipling  
---

# **40. Recommended Development Order**

If I were personally building this with you, I'd follow exactly this order:

                IDEA  
                   │  
                   ▼  
          ┌─────────────────┐  
          │ V0.1 Typography │  
          └────────┬────────┘  
                   │  
                   ▼  
          ┌─────────────────┐  
          │ Poetry Engine   │  
          └────────┬────────┘  
                   │  
                   ▼  
          ┌─────────────────┐  
          │ Desktop Window  │  
          └────────┬────────┘  
                   │  
                   ▼  
          ┌─────────────────┐  
          │ Video Wallpaper │  
          └────────┬────────┘  
                   │  
                   ▼  
          ┌─────────────────┐  
          │ Idle Detection  │  
          └────────┬────────┘  
                   │  
                   ▼  
          ┌─────────────────┐  
          │ Synchronisation │  
          └────────┬────────┘  
                   │  
                   ▼  
          ┌─────────────────┐  
          │ Custom Content  │  
          └────────┬────────┘  
                   │  
                   ▼  
          ┌─────────────────┐  
          │ Polish \+ Tests  │  
          └────────┬────────┘  
                   │  
                   ▼  
             GITHUB BETA  
---
