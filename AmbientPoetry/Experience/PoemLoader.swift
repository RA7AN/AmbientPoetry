import Foundation

enum PoemLoader {
    static func loadBundledPoems() -> [Poem] {
        guard let urls = Bundle.main.urls(forResourcesWithExtension: "json", subdirectory: "Poems")
                ?? Bundle.main.urls(forResourcesWithExtension: "json", subdirectory: nil) else {
            return [Self.fallbackPoem]
        }

        let poems = urls.compactMap { url -> Poem? in
            guard let data = try? Data(contentsOf: url) else { return nil }
            return try? JSONDecoder().decode(Poem.self, from: data)
        }
        .sorted { $0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending }

        return poems.isEmpty ? [Self.fallbackPoem] : poems
    }

    static func loadDefault() -> Poem {
        loadBundledPoems().first { $0.id == "if-kipling" } ?? loadBundledPoems()[0]
    }

    private static let fallbackPoem = Poem(
        id: "if-kipling",
        title: "If—",
        author: "Rudyard Kipling",
        stanzas: [
            Stanza(
                lines: [
                    "If you can keep your head",
                    "when all about you",
                    "are losing theirs",
                    "and blaming it on you,"
                ],
                displayDuration: 12
            )
        ]
    )
}
