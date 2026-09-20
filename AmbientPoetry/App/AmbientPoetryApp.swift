import SwiftUI
import AppKit

@main
struct AmbientPoetryApp: App {
    @State private var appState = AppState()
    @State private var didBootstrap = false

    var body: some Scene {
        MenuBarExtra("Ambient Poetry", systemImage: "text.quote") {
            Group {
                Button(appState.isPaused ? "Resume" : "Pause") {
                    appState.togglePause()
                }
                .keyboardShortcut("p", modifiers: [.command])

                Divider()

                Menu("Animation") {
                    ForEach(AnimationStyle.allCases) { style in
                        Button {
                            appState.setStyle(style)
                        } label: {
                            if appState.experience.animationStyle == style {
                                Text("✓ \(style.label)")
                            } else {
                                Text(style.label)
                            }
                        }
                    }
                }

                Divider()

                SettingsLink {
                    Text("Settings…")
                }
                .keyboardShortcut(",", modifiers: [.command])

                Divider()

                Button("Quit Ambient Poetry") {
                    NSApplication.shared.terminate(nil)
                }
                .keyboardShortcut("q", modifiers: [.command])
            }
            .onAppear(perform: bootstrapIfNeeded)
        }

        Settings {
            SettingsView(appState: appState)
                .onAppear(perform: bootstrapIfNeeded)
        }
    }

    private func bootstrapIfNeeded() {
        guard !didBootstrap else { return }
        didBootstrap = true
        NSApp.setActivationPolicy(.accessory)
        appState.start()
    }
}
