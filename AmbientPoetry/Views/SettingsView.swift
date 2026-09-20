import LaunchAtLogin
import SwiftUI

struct SettingsView: View {
    @Bindable var appState: AppState

    var body: some View {
        Form {
            Section("Playback") {
                Toggle("Paused", isOn: $appState.isPaused)
                Picker("Animation", selection: $appState.experience.animationStyle) {
                    ForEach(AnimationStyle.allCases) { style in
                        Text(style.label).tag(style)
                    }
                }
                .onChange(of: appState.experience.animationStyle) { _, _ in
                    appState.applyExperienceEdits()
                }

                Text(appState.experience.animationStyle.detail)
                    .font(.callout)
                    .foregroundStyle(.secondary)

                Slider(value: $appState.experience.timingScale, in: 0.5...1.75, step: 0.05) {
                    Text("Timing")
                } minimumValueLabel: {
                    Text("Faster")
                } maximumValueLabel: {
                    Text("Slower")
                }
                .onChange(of: appState.experience.timingScale) { _, _ in
                    appState.applyExperienceEdits()
                }
            }

            Section("Typography") {
                Picker("Family", selection: $appState.experience.typography.family) {
                    ForEach(TypographyFamily.allCases) { family in
                        Text(family.label).tag(family)
                    }
                }
                .onChange(of: appState.experience.typography.family) { _, _ in
                    appState.applyExperienceEdits()
                }

                Picker("Layout", selection: $appState.experience.typography.layout) {
                    ForEach(PoetryLayout.allCases) { layout in
                        Text(layout.label).tag(layout)
                    }
                }
                .onChange(of: appState.experience.typography.layout) { _, _ in
                    appState.applyExperienceEdits()
                }

                Slider(
                    value: Binding(
                        get: { Double(appState.experience.typography.pointSize) },
                        set: {
                            appState.experience.typography.pointSize = CGFloat($0)
                            appState.applyExperienceEdits()
                        }
                    ),
                    in: 24...48,
                    step: 1
                ) {
                    Text("Size")
                }
            }

            Section("Poem") {
                Picker("Active poem", selection: Binding(
                    get: { appState.experience.poem.id },
                    set: { id in
                        if let poem = appState.availablePoems.first(where: { $0.id == id }) {
                            appState.selectPoem(poem)
                        }
                    }
                )) {
                    ForEach(appState.availablePoems) { poem in
                        Text("\(poem.title) — \(poem.author)").tag(poem.id)
                    }
                }
            }

            Section("System") {
                LaunchAtLogin.Toggle()
                Text("Poetry plays on a click-through desktop layer. Use the menu bar icon to pause or quit.")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
        }
        .formStyle(.grouped)
        .padding()
        .frame(width: 420, height: 520)
    }
}
