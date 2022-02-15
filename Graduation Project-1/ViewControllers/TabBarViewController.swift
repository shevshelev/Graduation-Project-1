//
//  TabBarViewController.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 09.02.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private var cartProduct = RealmPersistentManager.shared.getProducts()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBadge()
    }
    
    private func setupBadge() {
        if cartProduct.count != 0 {
            guard let viewControllers = viewControllers else {return}
            for vc in viewControllers {
                if let cartVC = vc as? CartViewController {
                    var orderedAmount = 0
                    for product in cartProduct {
                        guard let amount = product.orderedAmount else {return}
                        orderedAmount = orderedAmount + amount
                    }
                    cartVC.tabBarItem.badgeValue = String(orderedAmount)
                }
            }
        }
    }
}
