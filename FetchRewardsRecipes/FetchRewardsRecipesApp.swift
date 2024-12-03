//
//  FetchRewardsRecipesApp.swift
//  FetchRewardsRecipes
//
//  Created by Camden Stocker on 11/26/24.
//

import SwiftUI

@main
struct FetchRewardsRecipesApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {            
                ContentView()
                    .navigationTitle("Recipes")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
