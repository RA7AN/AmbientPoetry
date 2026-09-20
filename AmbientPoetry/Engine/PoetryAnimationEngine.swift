import Foundation
import Observation

/// Timeline-driven poetry playback. Styles share the same stanza loop; only reveal choreography changes.
@MainActor
@Observable
final class PoetryAnimationEngine {
    private(set) var phase: Phase = .idle
    private(set) var stanzaIndex: Int = 0
    private(set) var visibleLineCount: Int = 0
    private(set) var showsAuthorCredit: Bool = false
    private(set) var opacity: Double = 0
    private(set) var drift: CGFloat = 0

    var isPaused: Bool = false {
        didSet {
            if isPaused {
                cancelWork()
            } else if phase == .idle || phase == .betweenStanzas {
                Task { await playLoop() }
            }
        }
    }

    private var experience: Experience
    private var loopTask: Task<Void, Never>?

    enum Phase: Equatable {
        case idle
        case entering
        case revealing
        case holding
        case exiting
        case betweenStanzas
        case authorCredit
    }

    init(experience: Experience) {
        self.experience = experience
    }

    var currentStanza: Stanza? {
        let stanzas = experience.poem.stanzas
        guard stanzas.indices.contains(stanzaIndex) else { return nil }
        return stanzas[stanzaIndex]
    }

    var visibleLines: [String] {
        guard let stanza = currentStanza else { return [] }
        return Array(stanza.lines.prefix(visibleLineCount))
    }

    func updateExperience(_ experience: Experience) {
        let styleChanged = self.experience.animationStyle != experience.animationStyle
            || abs(self.experience.timingScale - experience.timingScale) > 0.001
            || self.experience.poem.id != experience.poem.id
        self.experience = experience
        if styleChanged {
            restart()
        }
    }

    func start() {
        guard loopTask == nil else { return }
        Task { await playLoop() }
    }

    func restart() {
        cancelWork()
        stanzaIndex = 0
        visibleLineCount = 0
        showsAuthorCredit = false
        opacity = 0
        drift = 0
        phase = .idle
        Task { await playLoop() }
    }

    func stop() {
        cancelWork()
        phase = .idle
        opacity = 0
    }

    private func cancelWork() {
        loopTask?.cancel()
        loopTask = nil
    }

    private func playLoop() async {
        cancelWork()
        let task = Task { @MainActor in
            while !Task.isCancelled {
                if isPaused {
                    try? await Task.sleep(nanoseconds: 200_000_000)
                    continue
                }

                let poem = experience.poem
                guard !poem.stanzas.isEmpty else { return }

                for index in poem.stanzas.indices {
                    if Task.isCancelled || isPaused { break }
                    stanzaIndex = index
                    showsAuthorCredit = false
                    await playStanza(poem.stanzas[index])
                    await sleepScaled(0.8)
                }

                if Task.isCancelled || isPaused { continue }
                await playAuthorCredit()
                await sleepScaled(1.2)
            }
        }
        loopTask = task
        await task.value
    }

    private func playStanza(_ stanza: Stanza) async {
        let scale = max(0.35, experience.timingScale)
        let base = stanza.displayDuration * scale

        switch experience.animationStyle {
        case .cinematicFade:
            visibleLineCount = stanza.lines.count
            drift = 8
            phase = .entering
            await animateOpacity(to: 1, duration: 1.1 * scale)
            drift = 0
            phase = .holding
            await sleepScaled(max(2.5, base * 0.55))
            phase = .exiting
            await animateOpacity(to: 0, duration: 1.0 * scale)

        case .progressiveLines:
            visibleLineCount = 0
            opacity = 1
            drift = 0
            phase = .revealing
            let perLine = max(0.7, (base * 0.55) / Double(max(stanza.lines.count, 1)))
            for count in 1...stanza.lines.count {
                if Task.isCancelled || isPaused { return }
                visibleLineCount = count
                drift = 6
                await sleepScaled(0.15)
                drift = 0
                await sleepScaled(perLine)
            }
            phase = .holding
            await sleepScaled(max(2.0, base * 0.35))
            phase = .exiting
            await animateOpacity(to: 0, duration: 0.9 * scale)
            opacity = 1

        case .stanzaReveal:
            visibleLineCount = 0
            opacity = 1
            phase = .revealing
            let perLine = max(0.45, (base * 0.4) / Double(max(stanza.lines.count, 1)))
            for count in 1...stanza.lines.count {
                if Task.isCancelled || isPaused { return }
                visibleLineCount = count
                await sleepScaled(perLine)
            }
            phase = .holding
            await sleepScaled(max(3.0, base * 0.5))
            phase = .exiting
            await animateOpacity(to: 0, duration: 1.0 * scale)
            opacity = 1
        }

        phase = .betweenStanzas
        visibleLineCount = 0
    }

    private func playAuthorCredit() async {
        phase = .authorCredit
        showsAuthorCredit = true
        visibleLineCount = 0
        opacity = 0
        await animateOpacity(to: 1, duration: 0.9)
        await sleepScaled(3.5)
        await animateOpacity(to: 0, duration: 0.9)
        showsAuthorCredit = false
        phase = .betweenStanzas
    }

    private func animateOpacity(to value: Double, duration: TimeInterval) async {
        opacity = value
        await sleepScaled(duration)
    }

    private func sleepScaled(_ seconds: TimeInterval) async {
        let ns = UInt64(max(0, seconds) * 1_000_000_000)
        try? await Task.sleep(nanoseconds: ns)
    }
}
