//
//  RecipeListViewModelTests.swift
//  FetchRewardsRecipesTests
//
//  Created by Camden Stocker on 12/2/24.
//

import Testing
@testable import FetchRewardsRecipes

fileprivate struct MockRecipeServiceSuccess: RecipeAPIService {
    func getRecipes() async -> Result<[FetchRewardsRecipes.Recipe], FetchRewardsRecipes.RecipesAPIError> {
        return .success(
            [
                Recipe(
                    uuid: "TestUUID1",
                    cuisine: "American1",
                    name: "Pizza1",
                    photoUrlLarge: "url_large_stub",
                    photoUrlSmall: "url_small_stub",
                    sourceUrl: "source_url_stub",
                    youtubeUrl: "youtube_url_stub"
                ),
                Recipe(
                    uuid: "TestUUID2",
                    cuisine: "American2",
                    name: "Pizza2",
                    photoUrlLarge: "url_large_stub",
                    photoUrlSmall: "url_small_stub",
                    sourceUrl: "source_url_stub",
                    youtubeUrl: "youtube_url_stub"
                )
            ]
        )
    }
}

fileprivate struct MockRecipeServiceFailure: RecipeAPIService {
    func getRecipes() async -> Result<[FetchRewardsRecipes.Recipe], FetchRewardsRecipes.RecipesAPIError> {
        return .failure(.unknownError("UnknownError"))
    }
}

@MainActor
struct RecipeListViewModelTests {
    @Test("fetchRecipes on success sets recipes correctly")
    func fetchRecipesOnSuccess() async {
        let viewModel = RecipeListViewModel(
            recipeService: MockRecipeServiceSuccess()
        )
        
        await viewModel.fetchRecipes()
        let expectedRecipes = [
            Recipe(
                uuid: "TestUUID1",
                cuisine: "American1",
                name: "Pizza1",
                photoUrlLarge: "url_large_stub",
                photoUrlSmall: "url_small_stub",
                sourceUrl: "source_url_stub",
                youtubeUrl: "youtube_url_stub"
            ),
            Recipe(
                uuid: "TestUUID2",
                cuisine: "American2",
                name: "Pizza2",
                photoUrlLarge: "url_large_stub",
                photoUrlSmall: "url_small_stub",
                sourceUrl: "source_url_stub",
                youtubeUrl: "youtube_url_stub"
            )
        ]
        #expect(viewModel.recipes == expectedRecipes)
    }
    
    @Test("fetchRecipes on Failure sets apiError")
    func fetchRecipesOnFailure() async {
        let viewModel = RecipeListViewModel(
            recipeService: MockRecipeServiceFailure()
        )
        
        await viewModel.fetchRecipes()
        #expect(viewModel.apiError == .unknownError("UnknownError"))
    }
    
    @Test("Resetting apiError also resets alertIsPresented")
    func apiErrorDidSet() {
        let viewModel = RecipeListViewModel(
            recipeService: MockRecipeServiceFailure()
        )
        viewModel.apiError = .decodingError
        #expect(viewModel.alertIsPresented == true)
        viewModel.apiError = nil
        #expect(viewModel.alertIsPresented == false)
    }
    
    @Test("Search Query filters results correctly on cuisine")
    func searchQueryFiltersCorrectlyForCuising() async throws {
        let viewModel = RecipeListViewModel(
            recipeService: MockRecipeServiceSuccess()
        )
        
        await viewModel.fetchRecipes()
        
        viewModel.searchQuery = "American"
        #expect(viewModel.filteredRecipes.count == 2)
        
        viewModel.searchQuery = "American1"
        #expect(viewModel.filteredRecipes.count == 1)
        let recipe = try #require(viewModel.filteredRecipes.first)
        #expect(recipe.cuisine == "American1")
    }
    
    @Test("Search Query filters results correctly on name")
    func searchQueryFiltersCorrectlyForName() async throws {
        let viewModel = RecipeListViewModel(
            recipeService: MockRecipeServiceSuccess()
        )
        
        await viewModel.fetchRecipes()
        
        viewModel.searchQuery = "Pizza"
        #expect(viewModel.filteredRecipes.count == 2)
        
        viewModel.searchQuery = "Pizza1"
        #expect(viewModel.filteredRecipes.count == 1)
        let recipe = try #require(viewModel.filteredRecipes.first)
        #expect(recipe.name == "Pizza1")
    }
    
    @Test("Search Query filters to nothing for gibberish search query")
    func searchQueryFiltersCorrectlyForGibberish() async throws {
        let viewModel = RecipeListViewModel(
            recipeService: MockRecipeServiceSuccess()
        )
        
        await viewModel.fetchRecipes()
        
        viewModel.searchQuery = "Gibberish"
        #expect(viewModel.filteredRecipes == [])
    }
}
