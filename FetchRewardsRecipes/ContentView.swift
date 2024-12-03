//
//  ContentView.swift
//  FetchRewardsRecipes
//
//  Created by Camden Stocker on 11/26/24.
//

import SwiftUI

struct ContentView: View {
    @State private var recipes: [Recipe] = []
    
    var body: some View {
        NavigationStack {
            RecipeListContainerView()
                .navigationTitle("Recipes")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
