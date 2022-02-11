//
//  RealmPersistentManager.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 28.01.2022.
//

import RealmSwift

class RealmPersistentManager {
    
    static let shared = RealmPersistentManager()
    
    let realm = try! Realm()
    
    private init() {}
    
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
    
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
