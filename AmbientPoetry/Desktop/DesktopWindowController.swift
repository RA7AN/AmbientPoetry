import AppKit
import SwiftUI

/// Borderless, click-through window parked at the desktop wallpaper level (below icons).
@MainActor
final class DesktopWindowController {
    private var window: NSWindow?
    private var hostingController: NSHostingController<ExperienceView>?

    func show(experience: Experience, engine: PoetryAnimationEngine) {
        if window == nil {
            createWindow(experience: experience, engine: engine)
        } else {
            refresh(experience: experience, engine: engine)
        }
        repositionToMainScreen()
        window?.orderBack(nil)
    }

    func refresh(experience: Experience, engine: PoetryAnimationEngine) {
        let view = ExperienceView(experience: experience, engine: engine)
        if let hostingController {
            hostingController.rootView = view
        } else if let window {
            let host = NSHostingController(rootView: view)
            hostingController = host
            window.contentViewController = host
        }
    }

    func hide() {
        window?.orderOut(nil)
    }

    private func createWindow(experience: Experience, engine: PoetryAnimationEngine) {
        let screenFrame = NSScreen.main?.frame ?? NSRect(x: 0, y: 0, width: 1920, height: 1080)
        let host = NSHostingController(rootView: ExperienceView(experience: experience, engine: engine))
        hostingController = host

        let window = NSWindow(
            contentRect: screenFrame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        window.contentViewController = host
        window.setFrame(screenFrame, display: true)
        window.isOpaque = false
        window.backgroundColor = .clear
        window.hasShadow = false
        window.ignoresMouseEvents = true
        window.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.desktopWindow)))
        window.collectionBehavior = [
            .canJoinAllSpaces,
            .stationary,
            .ignoresCycle,
            .fullScreenAuxiliary
        ]
        window.isReleasedWhenClosed = false
        window.collectionBehavior.insert(.transient)

        self.window = window

        NotificationCenter.default.addObserver(
            forName: NSApplication.didChangeScreenParametersNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            Task { @MainActor in
                self?.repositionToMainScreen()
            }
        }
    }

    private func repositionToMainScreen() {
        guard let window, let screen = NSScreen.main else { return }
        window.setFrame(screen.frame, display: true)
    }
}
