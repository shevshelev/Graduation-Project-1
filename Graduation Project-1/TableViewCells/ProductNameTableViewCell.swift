
//  ProuductNameTableViewCell.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 25.01.2022.
//

import UIKit

class ProductNameTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!

    func setupCell(product: Product) {
        nameLabel.text = product.name
        priceLabel.text = "\(Double(product.price) ?? 0)₽"
    }
}
