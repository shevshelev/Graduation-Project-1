//
//  Category.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 18.01.2022.
//

struct Category {
    let id: Int
    let name: String
    let sortOrder: Int
    let image: String
    let subcategories: [Subcategories]
    
    init(key: String, data: [String: Any]) {
        let idData = key
        let sort = data["sortOrder"] as? String ?? ""
        var arrayOfSubcategory: [Subcategories] = []
        
        if let subcategoriesData = data["subcategories"] as? [[String: Any]] {
            for data in subcategoriesData {
                let subcategory = Subcategories(data: data)
                arrayOfSubcategory.append(subcategory)
            }
        }
        id = Int(idData) ?? 0
        name = data["name"] as? String ?? ""
        image = data["image"] as? String ?? ""
        sortOrder = Int(sort) ?? 1000
        subcategories = arrayOfSubcategory
    }
}

struct Subcategories {
    let id: Int
    let iconImage: String
    let sortOrder: Int
    let name: String
    
    init(data: [String: Any]) {
        
        let idData = data["id"] as? String ?? ""
        let sortOrderData = data["sortOrder"] as? String ?? ""
        
        id = Int(idData) ?? 0
        iconImage = data["iconImage"] as? String ?? ""
        name = data["name"] as? String ?? ""
        sortOrder = Int(sortOrderData) ?? 0
    }
}

extension Category: Comparable {
    static func < (lhs: Category, rhs: Category) -> Bool {
        lhs.sortOrder < rhs.sortOrder
    }
}

extension Subcategories: Comparable{
    static func < (lhs: Subcategories, rhs: Subcategories) -> Bool {
        lhs.sortOrder < lhs.sortOrder
    }
}

