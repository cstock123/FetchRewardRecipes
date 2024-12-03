//
//  RecipeListViewModel.swift
//  FetchRewardsRecipes
//
//  Created by Camden Stocker on 12/2/24.
//

import Foundation
import SwiftUI

@MainActor
@Observable
class RecipeListViewModel {
    let recipeService: any RecipeAPIService
    var recipes = [Recipe]()
    var filteredRecipes: [Recipe] {
        guard searchQuery != "" else { return recipes }
        return recipes.filter { recipe in
            recipe.name.contains(searchQuery) ||
            recipe.cuisine.contains(searchQuery)
        }
    }
    var searchQuery: String = ""
    var isLoading: Bool = false
    var apiError: RecipesAPIError? = nil {
        didSet {
            if apiError == nil {
                alertIsPresented = false
            } else {
                alertIsPresented = true
            }
        }
    }
    var alertIsPresented: Bool = false
    
    init(recipeService: any RecipeAPIService) {
        self.recipeService = recipeService
    }
    
    func loadRecipes() async {
        isLoading = true
        await fetchRecipes()
        isLoading = false
    }
    
    func fetchRecipes() async {
        #if DEBUG
        // Helpful to debug UI for slow running network requests.
        do { try await Task.sleep(for: .seconds(1)) } catch {}
        #endif
        
        switch await recipeService.getRecipes() {
        case .success(let recipes):
            self.recipes = recipes
        case .failure(let apiError):
            self.apiError = apiError
        }
    }
}
