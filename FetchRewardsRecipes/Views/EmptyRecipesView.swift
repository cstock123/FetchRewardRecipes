//
//  EmptyRecipesView.swift
//  FetchRewardsRecipes
//
//  Created by Camden Stocker on 12/3/24.
//

import SwiftUI

struct EmptyRecipesView: View {
    var viewModel: RecipeListViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "fork.knife")
                .resizable()
                .frame(width: 150, height: 150)
            
            Text("No Recipes Found")
                .font(.title3)
            
            Button("Try Again") {
                Task {
                    await viewModel.loadRecipes()
                }
            }
            .buttonStyle(.bordered)
        }
    }
}
