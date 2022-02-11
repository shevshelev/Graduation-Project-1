//
//  NetworkingManager.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 18.01.2022.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchCategory(urlString: String, completion: @escaping (Result<[Category], Error>) -> Void) {
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "Some error")
                return
            }
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                guard let dict = result as? [String: Any] else {return}
                var categories: [Category] = []
                for (key, data) in dict {
                    if let data = data as? [String: Any] {
                        let category = Category(key: key, data: data)
                            categories.append(category)
                    }
                }
                completion(.success(categories))
            } catch let jsonError {
                print("Fail", jsonError.localizedDescription)
                completion(.failure(jsonError))
            }
        }
        .resume()
    }
    
    func fetchProducts(productId: Int, completion: @escaping (Result<BSW, Error>) -> Void) {
        let urlString = "https://blackstarshop.ru/index.php?route=api/v1/products&cat_id=" + String(productId)
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "Some error")
                return
            }
            do {
                let products = try JSONDecoder().decode(BSW.self, from: data)
                completion(.success(products))
            } catch let jsonError {
                print("Fail", jsonError.localizedDescription)
                completion(.failure(jsonError))
            }
        } .resume()
    }
    
//    func fetchImage(imageUrl: String) -> UIImage? {
//        let imageUrlString = "https://blackstarwear.ru/" + imageUrl
//        var image = UIImage(systemName: "star.circle.fill")?.withTintColor(.black)
//        guard let imageUrl = URL(string: imageUrlString) else {return image}
//        guard let imageData = try? Data(contentsOf: imageUrl) else {return image}
//        image = UIImage(data: imageData)
//        return image
//    }
    
    func fetchImage(from imageURL: URL, completion: @escaping(Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "Something went wrong")
                return
            }
            DispatchQueue.main.async {
                completion(data, response)
            }
        } .resume()
    }
    private init() {}
}

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
