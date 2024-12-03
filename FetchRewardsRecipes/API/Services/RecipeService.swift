//
//  RecipeService.swift
//  FetchRewardsRecipes
//
//  Created by Camden Stocker on 12/3/24.
//

import Foundation

protocol RecipeAPIService {
    func getRecipes() async -> Result<[Recipe], RecipesAPIError>
}

struct RecipeService: RecipeAPIService {
    func getRecipes() async -> Result<[Recipe], RecipesAPIError> {
        do {
            let recipesResponse = try await API<Response>()
                .fetch(endpoint: Endpoint.Recipe.getRecipes)
            
            return .success(recipesResponse.recipes)
        } catch {
            print(error.localizedDescription)
            guard let apiError = error as? RecipesAPIError else {
                return .failure(RecipesAPIError.unknownError(error.localizedDescription))
            }
            return .failure(apiError)
       }
    }
}
