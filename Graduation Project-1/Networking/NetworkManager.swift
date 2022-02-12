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
