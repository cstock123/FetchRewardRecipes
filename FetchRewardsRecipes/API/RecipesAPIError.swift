//
//  RecipesAPIError.swift
//  FetchRewardsRecipes
//
//  Created by Camden Stocker on 11/26/24.
//

enum RecipesAPIError: Error, Equatable {
    case invalidRequest
    case invalidResponse
    case fourHundredError
    case serverError
    case decodingError
    case unknownError(String)
}
