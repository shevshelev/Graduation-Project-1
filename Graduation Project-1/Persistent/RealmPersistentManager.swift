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
    
    func createProduct(_ product: Product, _ offer: Offer) {
        write {
            let newProduct = realm.create(Product.self, value: ["article":product.article + "_" + offer.productOfferID], update: .modified)
            newProduct.orderedOffer = offer
            newProduct.price = product.price
            newProduct.collection = product.collection
            newProduct.colorImageURL = product.colorImageURL
            newProduct.colorName = product.colorName
            newProduct.englishName = product.englishName
            newProduct.mainImage = product.mainImage
            newProduct.offers = product.offers
            newProduct.oldPrice = product.oldPrice
            newProduct.productDescription = product.productDescription
            newProduct.productImages = product.productImages
            newProduct.recommendedProductIDs = product.recommendedProductIDs
            newProduct.sortOrder = product.sortOrder
            newProduct.tag = product.tag
            newProduct.name = product.name
            newProduct.orderedAmount = 1
        }
    }
    
    func addOffer(_ product: Product) {
        if let orderedAmount = product.orderedAmount {
            write {
                product.orderedAmount = orderedAmount + 1
            }
        }
    }
    
    func delOffer(_ product: Product) {
        if let orderedAmount = product.orderedAmount {
            write {
                product.orderedAmount = orderedAmount - 1
            }
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
