//
//  RecipeListContainerView.swift
//  FetchRewardsRecipes
//
//  Created by Camden Stocker on 12/3/24.
//

import SwiftUI

struct RecipeListContainerView: View {
    @State private var viewModel = RecipeListViewModel(
        recipeService: RecipeService()
    )
    
    let ALERT_TITLE = "To many cooks in the kitchen!"
    let ALERT_MESSAGE = "We've encountered an unexpected error. Please check your internet connection and try again."
    
    var body: some View {
        Group {
            if viewModel.recipes.isEmpty && !viewModel.isLoading {
                EmptyRecipesView(viewModel: viewModel)
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                RecipeListView(viewModel: viewModel)
            }
        }
        .alert(
            ALERT_TITLE,
            isPresented: $viewModel.alertIsPresented,
            actions: { alertButton },
            message: { Text(ALERT_MESSAGE) }
        )
        .task { await viewModel.loadRecipes() }
    }
    
    var alertButton: some View {
        Button("Ok", role: .cancel) {
            viewModel.apiError = nil
        }
    }
}
