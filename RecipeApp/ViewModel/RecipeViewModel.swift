//
//  RecipeViewModel.swift
//  RecipeApp
//
//  Created by Yogesh on 1/21/25.
//


//The following JSON endpoints provide the data for your project.
//
//All Recipes: https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json
//You’ll also find test endpoints to simulate various scenarios.
//
//Malformed Data: https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json
//Empty Data: https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json


import SwiftUI

@MainActor
class RecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
  
    
    
    private(set) var canLoadMore = true // Exposed as read-only
    private var currentPage = 1
    private let limit = 20
    private var isRequestInProgress = false
    private var isThrottled = false // Throttle flag

    // MARK: - Filter Recipes
    func filteredRecipes(searchQuery: String) -> [Recipe] {
        if searchQuery.isEmpty {
            return recipes
        } else {
            return recipes.filter { recipe in
                recipe.name.localizedCaseInsensitiveContains(searchQuery) ||
                recipe.cuisine.localizedCaseInsensitiveContains(searchQuery) ||
                (recipe.description?.localizedCaseInsensitiveContains(searchQuery) ?? false)
            }
        }
    }

    // MARK: - Load Recipes
    func loadRecipes() async {
        guard !isRequestInProgress else { return }
        resetPagination()
        throttleNetworkRequest {
            Task { [weak self] in
                guard let self = self else { return }
                self.isRequestInProgress = true
                self.isLoading = true

                do {
                    let newRecipes = try await RecipeService().fetchRecipes(page: self.currentPage, limit: self.limit)
                    self.recipes = newRecipes
                    self.canLoadMore = newRecipes.count == self.limit
                    if self.canLoadMore { self.currentPage += 1 }
                    self.errorMessage = nil // Clear any previous error
                } catch {
                    self.errorMessage = "Failed to load recipes: \(error.localizedDescription)"
                }

                self.isLoading = false
                self.isRequestInProgress = false
            }
        }
    }

    // MARK: - Load More Recipes
    func loadMoreRecipes() async {
        guard canLoadMore && !isRequestInProgress else { return }
        throttleNetworkRequest {
            Task { [weak self] in
                guard let self = self else { return }
                self.isRequestInProgress = true
                self.isLoading = true

                do {
                    let newRecipes = try await RecipeService().fetchRecipes(page: self.currentPage, limit: self.limit)
                    self.recipes.append(contentsOf: newRecipes)
                    self.canLoadMore = newRecipes.count == self.limit
                    if self.canLoadMore { self.currentPage += 1 }
                    self.errorMessage = nil // Clear any previous error
                } catch {
                    self.errorMessage = "Failed to load more recipes: \(error.localizedDescription)"
                }

                self.isLoading = false
                self.isRequestInProgress = false
            }
        }
    }

    // MARK: - Throttle Helper
    private func throttleNetworkRequest(action: @escaping () -> Void) {
        guard !isThrottled else { return }
        isThrottled = true

        action()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.isThrottled = false
        }
    }

    // MARK: - Reset Pagination
    private func resetPagination() {
        currentPage = 1
        canLoadMore = true
        recipes = []
        errorMessage = nil
    }
}
