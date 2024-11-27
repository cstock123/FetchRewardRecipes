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
            #if DEBUG
            // Helpful to debug UI for slow running network requests.
            try await Task.sleep(for: .seconds(1))
            #endif
            
            let recipesResponse = try await API<Response>()
                .fetch(endpoint: Endpoint.Recipe.getRecipes)
            
            withAnimation {
                recipes = recipesResponse.recipes
                    .sorted { $0.cuisine < $1.cuisine }
            }
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
        .refreshable { await viewModel.fetchRecipes() }
        .task { await viewModel.fetchRecipes() }
    }
}
