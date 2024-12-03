//
//  RecipeListView.swift
//  FetchRewardsRecipes
//
//  Created by Camden Stocker on 11/27/24.
//

import SwiftUI

struct RecipeListView: View {
    @Bindable var viewModel: RecipeListViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.filteredRecipes, id: \.uuid) { recipe in
                    RecipeRowView(recipe: recipe)
                    Divider()
                }
                
                if !viewModel.searchQuery.isEmpty &&
                    viewModel.filteredRecipes.isEmpty {
                    Text("No Results")
                }
            }
        }
        .refreshable { await viewModel.fetchRecipes() }
        .searchable(
            text: $viewModel.searchQuery,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search Recipes"
        )
    }
}
