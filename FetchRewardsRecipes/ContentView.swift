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
        ScrollView {
            LazyVStack {
                ForEach(recipes, id: \.uuid) { recipe in
                    Text(recipe.name)
                }
            }
        }
        .onAppear {
            Task {
                async let recipesResponse: Response = try! API<Response>()
                    .fetch(endpoint: Endpoint.Recipe.getRecipes)
                
                self.recipes = await recipesResponse.recipes
            }
        }
    }
}

#Preview {
    ContentView()
}
