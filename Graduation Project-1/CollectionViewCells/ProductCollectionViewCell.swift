//
//  ProductCollectionViewCell.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 19.01.2022.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var oldPriceLabel: UILabel!
    @IBOutlet var tagLabel: UILabel!
    
    func setupCell(_ product: Product) {
        nameLabel.text = product.name
        productImageView.image = ImageManager.shared.fetchImage(from: product.mainImage)
        priceLabel.text = "\(Double(product.price) ?? 0) руб."
        if let oldPrice = product.oldPrice {
            oldPriceLabel.attributedText = NSAttributedString(string: "\(Double(oldPrice) ?? 0) руб.", attributes: [.strikethroughStyle: 1])
        } else {
            oldPriceLabel.isHidden = true
        }
        if let tag = product.tag {
            tagLabel.text = tag
        } else {
            tagLabel.isHidden = true
        }
    }
}
