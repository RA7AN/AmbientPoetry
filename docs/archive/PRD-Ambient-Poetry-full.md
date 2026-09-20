# **PRD — Ambient Poetry**

**Working title:** Ambient Poetry  
 **Status:** Concept → Prototype  
 **Platform:** macOS  
 **Primary technology:** Swift / SwiftUI / AppKit / AVFoundation / Core Animation  
 **Initial distribution:** GitHub, open source  
 **Target:** Apple Silicon first, macOS 15+ initially  
 **Long-term:** polished macOS app / potentially App Store distribution

---

# **1\. Product Summary**

**Ambient Poetry** is a macOS application that transforms the desktop into a quiet, cinematic literary experience.

Instead of displaying a static inspirational quote, the application presents:

> **beautiful moving environments \+ carefully animated poetry**

Poems unfold gradually, stanza by stanza, while an ambient background—initially a static image and eventually an Aerial-style video—provides a continuously changing visual environment.

The goal is not to make the desktop distracting.

The goal is to make the user occasionally stop and read it.

### **Product thesis**

> **Your desktop doesn't have to demand your attention. It can occasionally give something back.**

---

# **2\. The Core Experience**

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

# **3\. The Problem**

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

# **4\. Product Principles**

These principles should guide every feature decision.

## **4.1 Typography comes first**

The poetry is the product.

The background should never overpower the writing.

---

## **4.2 Motion should be restrained**

Avoid:

* bouncing text  
* excessive zoom  
* karaoke-style word highlighting  
* flashy transitions  
* particles everywhere  
* gimmicky animations

Prefer:

* opacity  
* subtle translation  
* gentle scaling  
* line-by-line reveals  
* stanza transitions  
* slow environmental motion

---

## **4.3 The desktop should remain usable**

The application must never become:

> “Why is there a giant poem covering my Mac?”

It should feel like an ambient layer.

---

## **4.4 Long-form literature should be supported**

The system should not be designed exclusively around quotes.

It should support:

* poems  
* essays  
* excerpts  
* speeches  
* philosophical passages  
* public-domain literature  
* user-created writing

---

## **4.5 Offline-first**

The core experience should work without:

* accounts  
* cloud services  
* internet  
* telemetry  
* AI APIs

AI can become an optional future capability.

---

# **5\. Target User**

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

# **6\. Competitive Landscape**

The current ecosystem validates the technical feasibility but leaves room for differentiation.

### **Aerial**

Aerial provides Apple TV-style cinematic videos, live desktop wallpaper, overlays, playlists, custom videos and other functionality. Its current 4.1 release includes a native Wallpaper Extension.

This makes Aerial an important technical reference.

### **LiveWall**

LiveWall demonstrates a relatively straightforward architecture:

borderless desktop-level window  
        \+  
AVPlayerLooper  
        \+  
video

It supports hardware-accelerated playback and multi-display wallpapers.

### **LivePaper**

LivePaper explores desktop, lock-screen and screensaver video wallpapers on macOS Tahoe.

### **OpenLiveWalls**

OpenLiveWalls demonstrates another modern Swift approach using AVFoundation/VideoToolbox and native desktop wallpaper playback.

### **Animated**

Animated demonstrates desktop video playback plus experimentation with the macOS 26 lock-screen aerial format.

### **Gap**

These projects predominantly answer:

> **How can I put video on my Mac desktop?**

Ambient Poetry asks:

> **What should the desktop say to me?**

That is the differentiation.

---

# **7\. MVP Definition**

The first MVP should be deliberately tiny.

## **V1 MVP**

### **Background**

One static background.

For example:

* cinematic cityscape  
* mountains  
* ocean  
* rainy window  
* nighttime city

No video yet.

### **Poetry**

One poem:

**If— — Rudyard Kipling**

Potentially use a public-domain text and verify the applicable copyright status for distribution.

### **Animation**

Three experimental modes:

**A. Cinematic Fade**

If you can meet with  
        Triumph

fade in → linger → fade out.

**B. Progressive Lines**

If you can keep your head  
when all about you  
are losing theirs  
and blaming it on you,

Each line appears sequentially.

**C. Stanza Reveal**

The entire stanza appears progressively, followed by a long hold.

---

# **8\. V1 User Experience**

Launch application.

The user sees:

┌──────────────────────────────────────────────┐  
│                                              │  
│                                              │  
│                                              │  
│            If you can keep your head         │  
│                                              │  
│        when all about you                    │  
│        are losing theirs                     │  
│        and blaming it on you,                │  
│                                              │  
│                                              │  
└──────────────────────────────────────────────┘

After a pause:

                   ↓

The stanza fades.

Next stanza appears.

At the end:

                      — Rudyard Kipling

Then the cycle restarts.

---

# **9\. V1 Technical Architecture**

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

# **10\. Poetry Data Model**

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

# **11\. Poetry Animation Engine**

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

# **12\. Animation Styles**

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

# **13\. Typography**

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

# **14\. Layout System**

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

# **15\. V2 — Real Desktop Wallpaper**

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

# **16\. V3 — Live Backgrounds**

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

# **17\. V4 — Synchronised Ambient Experience**

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

# **18\. V5 — Idle-Aware Experience**

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

# **19\. V6 — Lock Screen / Aerial Integration**

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

# **20\. Multi-Monitor Support**

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

# **21\. Content System**

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

# **22\. Custom Poems**

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

# **23\. AI-Assisted Composition**

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

# **24\. Background Library**

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

# **25\. Sound**

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

# **26\. Power & Performance**

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

# **27\. Performance Targets**

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

# **28\. Accessibility**

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

# **29\. Settings**

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

# **30\. Menu Bar App**

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

# **31\. Content Authoring Format**

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

# **32\. Open Source Strategy**

I think open source is particularly appropriate for the first release.

The GitHub repository should contain:

AmbientPoetry/  
│  
├── Sources/  
│   ├── App/  
│   ├── Poetry/  
│   ├── Animation/  
│   ├── Wallpaper/  
│   ├── Rendering/  
│   └── Settings/  
│  
├── Resources/  
│   ├── Poems/  
│   ├── Fonts/  
│   └── Demo/  
│  
├── Tests/  
│  
├── Documentation/  
│  
├── README.md  
├── LICENSE  
├── CONTRIBUTING.md  
└── SECURITY.md  
---

# **33\. Version Plan**

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

# **34\. What Should NOT Be In V1**

This is equally important.

Do **not** build:

❌ AI poem generation  
 ❌ accounts  
 ❌ cloud sync  
 ❌ social network  
 ❌ community marketplace  
 ❌ subscriptions  
 ❌ analytics dashboard  
 ❌ web application  
 ❌ iOS application  
 ❌ 10,000-wallpaper library  
 ❌ complicated editor  
 ❌ authentication  
 ❌ backend  
 ❌ cryptocurrency, obviously 😄

The core loop must work first.

---

# **35\. The Ideal Beta**

If I were defining the “this is ready for GitHub” bar, I'd want someone to install it and experience this within **30 seconds**:

Install  
   ↓  
Launch  
   ↓  
Select poem  
   ↓  
Select background  
   ↓  
Enable Ambient Mode  
   ↓  
Go back to work

Then, eventually:

                USER LEAVES MAC  
                       ↓  
                 city begins moving  
                       ↓  
                 poetry appears  
                       ↓  
              stanza after stanza  
                       ↓  
                 user returns  
                       ↓  
             experience disappears

No tutorials.

No account.

No web dashboard.

No configuration hell.

---

# **36\. Longer-Term Vision — V2+**

Once the core experience works, the possibilities become much more interesting.

### **Adaptive poetry**

Different poems depending on:

* morning  
* evening  
* weekday  
* weekend  
* season

### **Location-aware environments**

Not necessarily precise location; potentially city/weather context with explicit user permission.

### **Weather-driven backgrounds**

Rain:

> melancholy poetry

Sunrise:

> hopeful poetry

Night:

> philosophical poetry

### **Calendar-aware experiences**

Before an exam:

> encouraging writing

Before a presentation:

> confidence-oriented writing

But these should be optional and privacy-first.

---

# **37\. Generative Backgrounds**

This is where your AI background could eventually become powerful.

Instead of:

Poem  
\+  
random video

the system could create:

Poem  
 ↓  
semantic analysis  
 ↓  
visual mood  
 ↓  
generated/selected environment  
 ↓  
cinematic composition

For example:

> “Do not go gentle into that good night”

could produce a completely different visual language from:

> “The peace of wild things.”

But again: **this is V2+**, not MVP.

---

# **38\. Potential Research Angle**

There is also an interesting HCI/research dimension here.

You could eventually investigate:

> **Does ambient literary content improve perceived desktop quality, mood, reflection, or attention during computer use?**

That could lead to:

* A/B experiments  
* animation studies  
* typography studies  
* attention measurements  
* user preference studies  
* idle-time behavior

Given your research background, this is potentially much more interesting than just shipping a wallpaper app.

---

# **39\. The Most Important Product Question**

The biggest risk isn't technical.

We already know technically that:

> **video \+ desktop \+ overlays is possible.**

Existing projects demonstrate that.

The question is:

> **Will people actually enjoy reading poetry on their desktop?**

That's why V0.1 should be almost embarrassingly simple.

Don't spend two weeks figuring out Aerial's internals before answering that question.

---

# **40\. Recommended Development Order**

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

# **41\. The GitHub Beta Definition**

I'd call the project **beta-ready** only when all of these are true:

### **Experience**

* Poetry looks genuinely beautiful.  
* Animations feel intentional rather than gimmicky.  
* Background never overwhelms text.  
* Experience works without configuration.

### **Technical**

* Native Swift.  
* Apple Silicon tested.  
* macOS 15+ tested.  
* Video playback stable.  
* Sleep/wake stable.  
* Multiple displays tested.  
* Battery behavior tested.  
* Memory leaks checked.  
* CPU usage measured.

### **Product**

* Menu bar controls.  
* Custom poems.  
* Custom backgrounds.  
* Animation presets.  
* Idle activation.  
* Settings.  
* Reset/default state.

### **Open Source**

* MIT/Apache-2.0 or another deliberate license.  
* README.  
* Installation instructions.  
* Screenshots.  
* Demo GIF/video.  
* Architecture documentation.  
* Contribution guide.  
* Issue templates.  
* Release notes.  
* Content licensing documentation.

---

# **42\. One Architectural Decision I'd Make Now**

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

# **43\. Final Product Vision**

The end state I would aim for is **not**:

> “A Mac app that displays inspirational quotes.”

It is:

> **A cinematic ambient layer for your computer, where literature unfolds slowly over living environments.**

The ideal user doesn't constantly interact with it.

They install it once.

They choose a mood.

Then they occasionally look up from their work and see:

6

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


