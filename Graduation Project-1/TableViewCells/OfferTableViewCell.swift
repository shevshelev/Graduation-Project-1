//
//  OfferTableViewCell.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 28.01.2022.
//

import UIKit

class OfferTableViewCell: UITableViewCell {

    @IBOutlet var sizeLabel: UILabel!
    
    func setupCell(offer: Offer) {
        sizeLabel.text = offer.size
    }
}
