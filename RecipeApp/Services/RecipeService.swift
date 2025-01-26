//
//  RecipeService.swift
//  RecipeApp
//
//  Created by Yogesh on 1/21/25.
//

import Foundation

enum RecipeServiceError: Error, LocalizedError {
    case invalidURL
    case emptyData
    case malformedData
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return "The URL provided is invalid."
            case .emptyData:
                return "No recipes are available."
            case .malformedData:
                return "The data received from the server is malformed."
            case .networkError(let error):
                return "Network error: \(error.localizedDescription)"
        }
    }
}
        
    class RecipeService {
        func fetchRecipes(page: Int, limit: Int) async throws -> [Recipe] {
            let urlString = CommandLine.arguments.contains("--invalid-url") ?
            "https://invalid-url.com" : // Invalid URL for error simulation
            "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json?page=\(page)&limit=\(limit)"
            
            guard let url = URL(string: urlString) else {
                throw RecipeServiceError.invalidURL
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let recipeResponse = try decoder.decode([String: [Recipe]].self, from: data)
            return recipeResponse["recipes"] ?? []
        }    
    
    
}

