//
//  RecipeImageView.swift
//  FetchRewardsRecipes
//
//  Created by Camden Stocker on 12/3/24.
//

import SwiftUI
import NukeUI

struct RecipeImageView: View {
    let imageSize: RecipeImageSize
    let recipe: Recipe
    
    var body: some View {
        LazyImage(url: imageSize.imageUrl(for: recipe)) {
            state in
            if let image = state.image {
                image
                    .foodImageSize(imageSize: imageSize)
            } else {
                Image(systemName: "fork.knife")
                    .foodImageSize(imageSize: imageSize)
            }
        }
        .processors(
            /**
             This increases performance. The small image we recieve back is still large.
             If we resize it to what we are using on the view, then there will be less pixels rendered.
             */
            [
                .resize(width: imageSize.size.width),
                .resize(height: imageSize.size.height),
            ]
        )
    }
}

fileprivate extension Image {
    func foodImageSize(imageSize: RecipeImageSize) -> some View {
        self
            .resizable()
            .frame(width: imageSize.size.width, height: imageSize.size.height)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
