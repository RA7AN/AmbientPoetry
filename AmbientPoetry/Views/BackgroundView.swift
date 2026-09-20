import AppKit
import SwiftUI

struct BackgroundView: View {
    let imageName: String

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color.black
                if let image = NSImage.loadBundledBackground(named: imageName) {
                    Image(nsImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .clipped()
                } else {
                    LinearGradient(
                        colors: [
                            Color(red: 0.05, green: 0.08, blue: 0.16),
                            Color(red: 0.12, green: 0.14, blue: 0.2),
                            Color(red: 0.18, green: 0.12, blue: 0.1)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }

                // Soft scrim so type stays readable without crushing the scene.
                LinearGradient(
                    colors: [
                        .black.opacity(0.15),
                        .black.opacity(0.35),
                        .black.opacity(0.45)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
        }
    }
}

private extension NSImage {
    static func loadBundledBackground(named name: String) -> NSImage? {
        if let image = NSImage(named: name) {
            return image
        }
        if let url = Bundle.main.url(forResource: name, withExtension: "png", subdirectory: "Backgrounds")
            ?? Bundle.main.url(forResource: name, withExtension: "png") {
            return NSImage(contentsOf: url)
        }
        if let url = Bundle.main.url(forResource: name, withExtension: "jpg", subdirectory: "Backgrounds")
            ?? Bundle.main.url(forResource: name, withExtension: "jpg") {
            return NSImage(contentsOf: url)
        }
        return nil
    }
}
