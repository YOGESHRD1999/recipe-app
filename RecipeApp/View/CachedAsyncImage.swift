//
//  CachedAsyncImage.swift
//  RecipeApp
//
//  Created by Yogesh on 1/22/25.
//

import SwiftUI

struct CachedAsyncImage: View {
    let url: URL
    @State private var image: UIImage?

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                ProgressView()
                    .frame(width: 80, height: 80)
            }
        }
        .onAppear {
            Task {
                image = await ImageCache.shared.image(for: url)
            }
        }
        .id(url) // Ensures SwiftUI refreshes when the URL changes
    }
}
