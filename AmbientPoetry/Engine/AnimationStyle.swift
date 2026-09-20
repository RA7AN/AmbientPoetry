import Foundation

enum AnimationStyle: String, CaseIterable, Identifiable, Hashable, Sendable {
    case cinematicFade
    case progressiveLines
    case stanzaReveal

    var id: String { rawValue }

    var label: String {
        switch self {
        case .cinematicFade: return "Cinematic Fade"
        case .progressiveLines: return "Progressive Lines"
        case .stanzaReveal: return "Stanza Reveal"
        }
    }

    var detail: String {
        switch self {
        case .cinematicFade:
            return "Whole stanza fades in, lingers, then fades out."
        case .progressiveLines:
            return "Each line appears in sequence."
        case .stanzaReveal:
            return "Lines build into a full stanza, then hold."
        }
    }
}
