//
//  RecipeRowView.swift
//  FetchRewardsRecipes
//
//  Created by Camden Stocker on 11/27/24.
//

import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack(spacing: 15) {
            RecipeImageView(imageSize: .small, recipe: recipe)
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                
                Text(recipe.cuisine)
                    .font(.subheadline)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    RecipeRowView(
        recipe: Recipe(
            uuid: UUID().uuidString,
            cuisine: "Chinese",
            name: "Potatoe Caserole",
            photoUrlLarge: "",
            photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f860d6d3-fc18-4c41-b368-2c86a44b79b8/small.jpg",
            sourceUrl: "",
            youtubeUrl: ""
        )
    )
}
