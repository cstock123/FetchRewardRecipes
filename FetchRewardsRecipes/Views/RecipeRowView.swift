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
            // TODO: Replace this with NukeUI's better caching component
            AsyncImage(url: URL(string: recipe.photoUrlSmall)!) { image in
                image
                    .foodImageSize()
            } placeholder: {
                Image(systemName: "fork.knife")
                    .foodImageSize()
            }
            
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

extension Image {
    func foodImageSize() -> some View {
        self
            .resizable()
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 10))
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
            youtubeUrl: ""
        )
    )
}
