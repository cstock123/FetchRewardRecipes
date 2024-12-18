//
//  Recipe.swift
//  FetchRewardsRecipes
//
//  Created by Camden Stocker on 11/26/24.
//

struct Recipe: Codable, Equatable {
    let uuid: String
    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    let youtubeUrl: String?
}
