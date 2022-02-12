//
//  RealmPersistentManager.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 28.01.2022.
//

import RealmSwift

class RealmPersistentManager {
    
    static let shared = RealmPersistentManager()
    
    private let realm = try! Realm()
    
    func save(_ product: Product) {
        write {
            realm.add(product)
        }
    }
    
    func delete(_ product: Product) {
        write {
            realm.delete(product)
        }
    }
    
    func deleteAll() {
        write {
            realm.deleteAll()
        }
    }
    
    func getProducts() -> Results<Product> {
        let products = realm.objects(Product.self)
        return products
    }
    
    func getProduct(_ article: String) -> Product? {
        let product = realm.object(ofType: Product.self, forPrimaryKey: article)
        return product
    }
    
    func addOffer(_ product: Product, _ offer: Offer) {
        write {
            product.orderedOffers.append(offer)
        }
    }
    
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    private init() {}
}
