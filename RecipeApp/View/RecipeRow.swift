//
//  RecipeRow.swift
//  RecipeApp
//
//  Created by Yogesh on 1/21/25.
//

import SwiftUI

struct RecipeRow: View {
    let recipe: Recipe

    var body: some View {
        HStack(spacing: 16) {
            // Recipe Image
            if let imageUrl = recipe.photoUrlSmall {
                AsyncImage(url: imageUrl) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 80, height: 80)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    case .success(let image):
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(recipe.name)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                if let description = recipe.description {
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                }
            }

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
}
