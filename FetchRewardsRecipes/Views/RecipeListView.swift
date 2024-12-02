//
//  RecipeListView.swift
//  FetchRewardsRecipes
//
//  Created by Camden Stocker on 11/27/24.
//

import SwiftUI

struct RecipeListView: View {
    @State private var viewModel = RecipeListViewModel()
    
    let ALERT_TITLE = "To many cooks in the kitchen!"
    let ALERT_MESSAGE = "We've encountered an unexpected error. Please check your internet connection and try again."
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.filteredRecipes, id: \.uuid) { recipe in
                    RecipeRowView(recipe: recipe)
                    Divider()
                }
            }
        }
        .alert(
            ALERT_TITLE,
            isPresented: $viewModel.alertIsPresented
        ) {
            alertButton
        } message: {
            Text(ALERT_MESSAGE)
        }
        .refreshable { await viewModel.fetchRecipes() }
        .searchable(text: $viewModel.searchQuery, prompt: "Search Recipes")
        .task { await viewModel.fetchRecipes() }
    }
    
    var alertButton: some View {
        Button("Ok", role: .cancel) {
            viewModel.apiError = nil
        }
    }
}
