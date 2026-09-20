import Foundation
import SwiftUI

struct Experience: Identifiable, Hashable, Sendable {
    var id: String
    var poem: Poem
    var backgroundImageName: String
    var typography: TypographySettings
    var animationStyle: AnimationStyle
    var timingScale: Double

    static func `default`(poem: Poem = PoemLoader.loadDefault()) -> Experience {
        Experience(
            id: "default-\(poem.id)",
            poem: poem,
            backgroundImageName: "city-night",
            typography: .literary,
            animationStyle: .progressiveLines,
            timingScale: 1.0
        )
    }
}

struct TypographySettings: Hashable, Sendable {
    var family: TypographyFamily
    var pointSize: CGFloat
    var layout: PoetryLayout

    static let literary = TypographySettings(
        family: .literary,
        pointSize: 34,
        layout: .lowerCenter
    )

    var font: Font {
        switch family {
        case .literary:
            return .system(size: pointSize, design: .serif)
        case .editorial:
            return .system(size: pointSize + 4, weight: .regular, design: .serif)
        case .modern:
            return .system(size: pointSize, weight: .light, design: .default)
        }
    }
}

enum TypographyFamily: String, CaseIterable, Identifiable, Hashable, Sendable {
    case literary
    case editorial
    case modern

    var id: String { rawValue }

    var label: String {
        switch self {
        case .literary: return "Literary"
        case .editorial: return "Editorial"
        case .modern: return "Modern"
        }
    }
}

enum PoetryLayout: String, CaseIterable, Identifiable, Hashable, Sendable {
    case center
    case lowerCenter

    var id: String { rawValue }

    var label: String {
        switch self {
        case .center: return "Center"
        case .lowerCenter: return "Lower center"
        }
    }

    var alignment: Alignment {
        switch self {
        case .center: return .center
        case .lowerCenter: return .bottom
        }
    }
}
