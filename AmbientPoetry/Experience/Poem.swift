import Foundation

struct Poem: Codable, Identifiable, Hashable, Sendable {
    var id: String
    var title: String
    var author: String
    var stanzas: [Stanza]
}

struct Stanza: Codable, Hashable, Sendable {
    var lines: [String]
    var displayDuration: TimeInterval

    enum CodingKeys: String, CodingKey {
        case lines
        case displayDuration
        case duration
    }

    init(lines: [String], displayDuration: TimeInterval) {
        self.lines = lines
        self.displayDuration = displayDuration
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lines = try container.decode([String].self, forKey: .lines)
        if let value = try container.decodeIfPresent(TimeInterval.self, forKey: .displayDuration) {
            displayDuration = value
        } else if let value = try container.decodeIfPresent(TimeInterval.self, forKey: .duration) {
            displayDuration = value
        } else {
            displayDuration = 12
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lines, forKey: .lines)
        try container.encode(displayDuration, forKey: .displayDuration)
    }
}
