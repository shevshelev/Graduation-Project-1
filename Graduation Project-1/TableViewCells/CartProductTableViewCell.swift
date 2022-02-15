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
    
    func setupCell(_ product: Product) {
        productImageView.image = ImageManager.shared.fetchImage(from: product.mainImage)
        nameLabel.text = product.name
        sizeLabel.text = "Размер: \(product.orderedOffer?.size ?? "") - \(product.orderedAmount ?? 0) шт."
        colorLabel.text = "Цвет: \(product.colorName)"
        priceLabel.text = "\(Double(product.price) ?? 0)"
    }
}
