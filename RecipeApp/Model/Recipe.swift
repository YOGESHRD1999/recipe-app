//
//  Recipe.swift
//  RecipeApp
//
//  Created by Yogesh on 1/21/25.
//

import Foundation

public struct Recipe: Codable, Identifiable, Equatable {
    let cuisine: String
    let name: String
    let description: String?
    let photoUrlLarge: URL?
    let photoUrlSmall: URL?
    let uuid: String
    let sourceUrl: URL?
    let youtubeUrl: URL?

    // Use `uuid` as the unique identifier for Identifiable conformance
    public var id: String { uuid }

    enum CodingKeys: String, CodingKey {
        case cuisine, name, description
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case uuid
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }

    // Equatable conformance: Compare recipes by `uuid`
    public static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}



// MARK: - Collection Extension
extension Collection {
    var isNotEmpty: Bool {
        !isEmpty
    }
}
