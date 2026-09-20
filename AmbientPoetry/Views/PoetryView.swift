import SwiftUI

struct PoetryView: View {
    let lines: [String]
    let font: Font
    let style: AnimationStyle

    var body: some View {
        VStack(alignment: .leading, spacing: style == .cinematicFade ? 14 : 12) {
            ForEach(Array(lines.enumerated()), id: \.offset) { _, line in
                Text(line)
                    .font(font)
                    .foregroundStyle(Color.white.opacity(0.92))
                    .shadow(color: .black.opacity(0.55), radius: 10, y: 2)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .transition(lineTransition)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var lineTransition: AnyTransition {
        switch style {
        case .cinematicFade:
            return .opacity
        case .progressiveLines, .stanzaReveal:
            return .asymmetric(
                insertion: .opacity.combined(with: .offset(y: 8)),
                removal: .opacity
            )
        }
    }
}
