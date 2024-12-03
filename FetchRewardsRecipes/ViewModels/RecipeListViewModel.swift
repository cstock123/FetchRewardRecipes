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
    
    func loadRecipes() async {
        isLoading = true
        await fetchRecipes()
        isLoading = false
    }
    
    func fetchRecipes() async {
        do {
            #if DEBUG
            // Helpful to debug UI for slow running network requests.
            try await Task.sleep(for: .seconds(1))
            #endif
            
            let recipesResponse = try await API<Response>()
                .fetch(endpoint: Endpoint.Recipe.getRecipes)
            
            recipes = recipesResponse.recipes
                .sorted { $0.cuisine < $1.cuisine }
        } catch {
            if let apiError = error as? RecipesAPIError {
                self.apiError = apiError
            } else {
                self.apiError = RecipesAPIError
                    .unknownError(error.localizedDescription)
            }
            print(error.localizedDescription)
        }
    }
}
