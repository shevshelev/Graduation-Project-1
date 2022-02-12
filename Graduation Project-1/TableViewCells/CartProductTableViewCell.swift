//
//  CartProductTableViewCell.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 03.02.2022.
//

import UIKit

class CartProductTableViewCell: UITableViewCell {
    
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var sizeLabel: UILabel!
    @IBOutlet var colorLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var trashButton: UIButton!
    
    var product = Product()
    
    func setupCell() {
        
        var sizes = ""
        
        for offer in product.orderedOffers {
            sizes += " \(offer.size)"
        }
        
        productImageView.image = ImageManager.shared.fetchImage(from: product.mainImage)
        nameLabel.text = product.name
        sizeLabel.text = "Размеры: " + sizes
        colorLabel.text = "Цвет: \(product.colorName)"
        priceLabel.text = "\(Double(product.price) ?? 0)"
    }
}
