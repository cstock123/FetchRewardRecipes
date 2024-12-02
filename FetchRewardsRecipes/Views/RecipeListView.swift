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
            if let apiError = error as? RecipesAPIError {
                self.apiError = apiError
            } else {
                self.apiError = RecipesAPIError
                    .unknownError(error.localizedDescription)
                print(error.localizedDescription)
            }
        }
    }
}

struct RecipeListView: View {
    @State private var viewModel = RecipeListViewModel()
    
    
    let ALERT_TITLE = "To many cooks in the kitchen!"
    let ALERT_MESSAGE = "We've encountered an unexpected error. Please check your internet connection and try again."
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.recipes, id: \.uuid) { recipe in
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
        .task { await viewModel.fetchRecipes() }
    }
    
    var alertButton: some View {
        Button("Ok", role: .cancel) {
            viewModel.apiError = nil
        }
    }
}
