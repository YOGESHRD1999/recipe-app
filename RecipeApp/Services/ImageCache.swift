//
//  ImageCache.swift
//  RecipeApp
//
//  Created by Yogesh on 1/22/25.
//

import UIKit

actor ImageCache {
    private var cache = NSCache<NSURL, UIImage>()

    static let shared = ImageCache()

    func image(for url: URL) async -> UIImage? {
        // Check in-memory cache
        if let cachedImage = cache.object(forKey: url as NSURL) {
            return cachedImage
        }

        // Check disk cache
        let fileURL = diskCacheURL(for: url)
        if let diskData = try? Data(contentsOf: fileURL),
           let diskImage = UIImage(data: diskData) {
            cache.setObject(diskImage, forKey: url as NSURL)
            return diskImage
        }

        // Fetch from network
        guard let (data, _) = try? await URLSession.shared.data(from: url),
              let image = UIImage(data: data) else {
            return nil
        }

        // Save to both caches
        cache.setObject(image, forKey: url as NSURL)
        saveImageToDisk(data: data, for: url)

        return image
    }

    private func saveImageToDisk(data: Data, for url: URL) {
        let fileURL = diskCacheURL(for: url)
        try? data.write(to: fileURL, options: .atomic)
    }

    private func diskCacheURL(for url: URL) -> URL {
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return cacheDirectory.appendingPathComponent(url.absoluteString.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? UUID().uuidString)
    }
}
