//
//  RecipeImageSizeTests.swift
//  FetchRewardsRecipesTests
//
//  Created by Camden Stocker on 12/3/24.
//

import Testing
import Foundation
@testable import FetchRewardsRecipes

struct RecipeImageSizeTests {

    @Test("RecipeImageSize has only two cases")
    func hasOnlyTwoCases() {
        #expect(RecipeImageSize.allCases.count == 2)
    }
    
    @Test(
        "RecipeImageSize.imageUrl returns nil for empty imageUrls",
        arguments: RecipeImageSize.allCases
    )
    func returnsNilForEmptyUrls(_ imageSize: RecipeImageSize) {
        let recipe = Recipe(
            uuid: "",
            cuisine: "",
            name: "",
            photoUrlLarge: nil,
            photoUrlSmall: nil,
            sourceUrl: nil,
            youtubeUrl: nil
        )
        
        #expect(imageSize.imageUrl(for: recipe) == nil)
    }
    
    @Test(
        "RecipeImageSize.imagerUrl returns a url for valid URLs",
        arguments: RecipeImageSize.allCases
    )
    func returnsUrlForValidUrls(_ imageSize: RecipeImageSize) {
        let recipe = Recipe(
            uuid: "",
            cuisine: "",
            name: "",
            photoUrlLarge: "https://test_large.com",
            photoUrlSmall: "https://test_small.com",
            sourceUrl: nil,
            youtubeUrl: nil
        )
        
        #expect(imageSize.imageUrl(for: recipe) != nil)
    }
    
    @Test("RecipeImagSize.size returns the correct size")
    func returnsCorrectSize() {
        #expect(RecipeImageSize.small.size == CGSize(width: 50, height: 50))
        #expect(RecipeImageSize.large.size == CGSize(width: 300, height: 300))
    }
}
