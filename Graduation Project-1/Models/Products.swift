//
//  Products.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 19.01.2022.
//

import RealmSwift

typealias BSW = [String: Product]

class Product: Object, Codable {
    @Persisted var name: String = ""
    @Persisted var englishName: String = ""
    @Persisted var sortOrder: String = ""
    @Persisted var article: String = ""
    @Persisted var collection: String?
    @Persisted var productDescription: String = ""
    @Persisted var colorName: String = ""
    @Persisted var colorImageURL: String = ""
    @Persisted var mainImage: String = ""
    @Persisted var productImages: List<ProductImage>
    @Persisted var offers: List<Offer>
    @Persisted var offer: Offer?
    @Persisted var recommendedProductIDs: List<String>
    @Persisted var price: String = ""
    @Persisted var oldPrice: String?
    @Persisted var tag: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case englishName
        case sortOrder
        case article
        case collection
        case productDescription = "description"
        case colorName
        case colorImageURL
        case mainImage
        case productImages
        case offers
        case recommendedProductIDs
        case price
        case oldPrice
        case tag
    }
}

class ProductImage: Object, Codable {
    @Persisted var imageURL: String = ""
    @Persisted var sortOrder: String = ""

}

class Offer: Object, Codable {
    @Persisted var size: String = ""
    @Persisted var productOfferID: String = ""
    @Persisted var quantity: String = ""
}

extension Product: Comparable {
    static func < (lhs: Product, rhs: Product) -> Bool {
        lhs.sortOrder < rhs.sortOrder
    }
}

extension ProductImage: Comparable {
    static func < (lhs: ProductImage, rhs: ProductImage) -> Bool {
        lhs.sortOrder < rhs.sortOrder
    }
}

extension Offer: Comparable {
    static func < (lhs: Offer, rhs: Offer) -> Bool {
        lhs.size < rhs.size
    }
    
    static func == (lhs: Offer, rhs: Offer) -> Bool {
        lhs.productOfferID == rhs.productOfferID
    }
}
