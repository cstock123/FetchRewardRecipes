//
//  RecipeListView.swift
//  FetchRewardsRecipes
//
//  Created by Camden Stocker on 11/27/24.
//

import SwiftUI

@MainActor
@Observable
class RecipeListViewModel {
    var recipes = [Recipe]()
    
    func fetchRecipes() async {
        do {
            let recipesResponse = try await API<Response>()
                .fetch(endpoint: Endpoint.Recipe.getRecipes)
            
            recipes = recipesResponse.recipes
        } catch {
            print(error)
        }
    }
}

struct RecipeListView: View {
    @State private var viewModel = RecipeListViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.recipes, id: \.uuid) { recipe in
                    RecipeRowView(recipe: recipe)
                }
            }
        }
        .task { await viewModel.fetchRecipes() }
    }
}
