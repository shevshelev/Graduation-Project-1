//
//  CategoryTableViewCell.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 09.02.2022.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet var categoryImage: UIImageView!
    @IBOutlet var categoryNameLabel: UILabel!
    
    func setupCell(_ category: Category) {
        categoryImage.layer.cornerRadius = 40
        categoryImage.image =  ImageManager.shared.fetchImage(from: category.image)
        categoryNameLabel.text = category.name
    }
}
