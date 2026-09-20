import AppKit
import Foundation
import Observation
import SwiftUI

@MainActor
@Observable
final class AppState {
    var experience: Experience
    var availablePoems: [Poem]
    var isPaused: Bool = false {
        didSet { engine.isPaused = isPaused }
    }
    var isSettingsPresented: Bool = false

    let engine: PoetryAnimationEngine
    private let desktopController = DesktopWindowController()

    init() {
        let poems = PoemLoader.loadBundledPoems()
        let poem = poems.first { $0.id == "if-kipling" } ?? poems[0]
        let experience = Experience.default(poem: poem)
        self.availablePoems = poems
        self.experience = experience
        self.engine = PoetryAnimationEngine(experience: experience)
    }

    func start() {
        desktopController.show(experience: experience, engine: engine)
        engine.start()
        observeExperienceChanges()
    }

    func togglePause() {
        isPaused.toggle()
    }

    func setStyle(_ style: AnimationStyle) {
        experience.animationStyle = style
        engine.updateExperience(experience)
        desktopController.refresh(experience: experience, engine: engine)
    }

    func applyExperienceEdits() {
        engine.updateExperience(experience)
        desktopController.refresh(experience: experience, engine: engine)
    }

    func selectPoem(_ poem: Poem) {
        experience.poem = poem
        experience.id = "default-\(poem.id)"
        applyExperienceEdits()
        engine.restart()
    }

    private func observeExperienceChanges() {
        // Desktop content is refreshed explicitly from settings / style actions.
    }
}
