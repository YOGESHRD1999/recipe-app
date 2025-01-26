//
//  RecipeListView.swift
//  RecipeApp
//
//  Created by Yogesh on 1/21/25.
//

import SwiftUI

struct RecipesView: View {
    @StateObject private var viewModel = RecipesViewModel()
    @State private var searchQuery = ""
    
 
        
    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange.opacity(0.2), Color.purple.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)

                VStack(spacing: 0) {
                // Search Bar
                    searchBar

                    // Main Content
                    if viewModel.isLoading && viewModel.recipes.isEmpty {
                        ProgressView("Loading Recipes...")
                            .scaleEffect(1.5)
                            .padding()
                            .accessibilityIdentifier("loadingIndicator")
                        
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                               .font(.headline)
                               .foregroundColor(.red)
                               .multilineTextAlignment(.center)
                               .padding()
                               .accessibilityIdentifier("errorMessage") // Identifier for the test
                    } else {
                        recipeList
                    }
                }
            }
            .navigationTitle("Recipes")
            .task {
                await viewModel.loadRecipes()
            }
        }
    }

    // MARK: - Search Bar
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 10)

            TextField("Search Recipes...", text: $searchQuery)
                .textFieldStyle(PlainTextFieldStyle())
                .foregroundColor(.black)
                .placeholder(when: searchQuery.isEmpty) {
                    Text("Search Recipes...")
                        .foregroundColor(.gray.opacity(0.6))
                }
                .accessibilityIdentifier("searchBar")
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }

    // MARK: - Recipe List
    private var recipeList: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.filteredRecipes(searchQuery: searchQuery)) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        RecipeRow(recipe: recipe)
                            .accessibilityIdentifier("recipeRow_\(recipe.uuid)")
                            .padding(.horizontal, 16)
                    }
                }

                if viewModel.isLoading && !viewModel.recipes.isEmpty {
                    ProgressView("Loading more recipes...")
                        .accessibilityIdentifier("loadingMoreIndicator")
                        .padding()
                }
            }
            .accessibilityIdentifier("recipeList")
            .padding(.vertical, 16)
            .onAppear {
                Task {
                    if viewModel.canLoadMore {
                        await viewModel.loadMoreRecipes()
                    }
                }
            }
            .overlay {
                if viewModel.filteredRecipes(searchQuery: searchQuery).isEmpty && !viewModel.isLoading {
                    Text("No recipes available. Please try again later.")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .accessibilityIdentifier("noRecipesMessage")
                }
            }
        }
        .accessibilityIdentifier("recipeList")
    }

    // MARK: - Error View
    private func errorView(error: String) -> some View {
        VStack(spacing: 16) {
            Text("Error: \(error)")
                .foregroundColor(.red)
                .multilineTextAlignment(.center)

            Button(action: {
                Task {
                    await viewModel.loadRecipes()
                }
            }) {
                Text("Retry")
                    .bold()
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red.opacity(0.8))
                    )
                    .foregroundColor(.white)
            }
        }
        .padding()
    }
}

// MARK: - Placeholder Extension
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}


