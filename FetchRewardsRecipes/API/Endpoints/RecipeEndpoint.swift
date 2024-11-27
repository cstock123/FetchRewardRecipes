//
//  RecipeEndpoint.swift
//  FetchRewardsRecipes
//
//  Created by Camden Stocker on 11/26/24.
//

import Foundation

enum Endpoint {
    enum Recipe: String {
        case getRecipes
        case getRecipesMalformed
        case getRecipesEmpty
    }
}

extension Endpoint.Recipe: APIEndpoint {
    func getUrlRequest() -> URLRequest? {
        let requestBuilder = URLRequestBuilder()
        
        return switch self {
        case .getRecipes:
            requestBuilder.buildRequest(path: "recipes.json", httpMethod: .get)
        case .getRecipesMalformed:
            requestBuilder.buildRequest(path: "recipes-malformed.json", httpMethod: .get)
        case .getRecipesEmpty:
            requestBuilder.buildRequest(path: "recipes-empty.json", httpMethod: .get)
        }
    }
}
