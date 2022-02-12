//
//  ImageManager.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 12.02.2022.
//

import UIKit

class ImageManager {
    
    static let shared = ImageManager()
    
    func fetchImage(from imageUrl: String) -> UIImage? {
        var image = UIImage(systemName: "star.circle.fill")
        guard let url = URL(string: "https://blackstarwear.ru/\(imageUrl)") else {
            return image
        }
        if let cachedImage = getCachedImage(from: url) {
            return cachedImage
        }
        NetworkManager.shared.fetchImage(from: url) { data, response in
            self.saveDataToCache(with: data, and: response)
            image = UIImage(data: data)
        }
        return image
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        guard let cachedResponse = URLCache.shared.cachedResponse(for: request) else { return nil }
        guard url.lastPathComponent == cachedResponse.response.url?.lastPathComponent else { return nil }
        return UIImage(data: cachedResponse.data)
    }
    
    private init() {}
}
