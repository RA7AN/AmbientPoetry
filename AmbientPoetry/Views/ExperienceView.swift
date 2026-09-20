import SwiftUI

struct ExperienceView: View {
    let experience: Experience
    var engine: PoetryAnimationEngine

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                BackgroundView(imageName: experience.backgroundImageName)
                poetryLayer(size: proxy.size)
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
        .ignoresSafeArea()
    }

    @ViewBuilder
    private func poetryLayer(size: CGSize) -> some View {
        let content = Group {
            if engine.showsAuthorCredit {
                Text("— \(experience.poem.author)")
                    .font(experience.typography.font.italic())
                    .foregroundStyle(Color.white.opacity(0.88))
                    .shadow(color: .black.opacity(0.55), radius: 8, y: 2)
            } else {
                PoetryView(
                    lines: engine.visibleLines,
                    font: experience.typography.font,
                    style: experience.animationStyle
                )
            }
        }
        .opacity(engine.opacity)
        .offset(y: engine.drift)
        .animation(.easeInOut(duration: 0.9), value: engine.opacity)
        .animation(.easeOut(duration: 0.45), value: engine.drift)
        .animation(.easeOut(duration: 0.35), value: engine.visibleLineCount)
        .frame(maxWidth: min(size.width * 0.72, 820))
        .padding(.horizontal, 48)

        switch experience.typography.layout {
        case .center:
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        case .lowerCenter:
            VStack {
                Spacer(minLength: size.height * 0.42)
                content
                Spacer(minLength: size.height * 0.14)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
