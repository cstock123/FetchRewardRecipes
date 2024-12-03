//
//  RecipeImageSize.swift
//  FetchRewardsRecipes
//
//  Created by Camden Stocker on 12/3/24.
//

import Foundation

enum RecipeImageSize: CaseIterable {
    case small, large
    
    func imageUrl(for recipe: Recipe) -> URL? {
        switch self {
        case .small:
            guard let smallUrl = recipe.photoUrlSmall else { return nil }
            return URL(string: smallUrl)
        case .large:
            guard let largeUrl = recipe.photoUrlLarge else { return nil }
            return URL(string: largeUrl)
        }
    }
    
    var size: CGSize {
        switch self {
        case .small:
            CGSize(width: 50, height: 50)
        case .large:
            CGSize(width: 300, height: 300)
        }
    }
}
