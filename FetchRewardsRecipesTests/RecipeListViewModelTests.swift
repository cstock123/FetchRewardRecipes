//
//  RecipeListViewModelTests.swift
//  FetchRewardsRecipesTests
//
//  Created by Camden Stocker on 12/2/24.
//

import Testing
@testable import FetchRewardsRecipes

@MainActor
struct RecipeListViewModelTests {
    var viewModel: RecipeListViewModel
    
    init() {
        self.viewModel = RecipeListViewModel()
    }

}
