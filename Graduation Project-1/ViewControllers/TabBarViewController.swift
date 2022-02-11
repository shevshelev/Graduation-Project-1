//
//  TabBarViewController.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 09.02.2022.
//

import UIKit
import RealmSwift

class TabBarViewController: UITabBarController {
    
    var cartProduct: Results<Product>!

    override func viewDidLoad() {
        super.viewDidLoad()
        cartProduct = RealmPersistentManager.shared.realm.objects(Product.self)
        setupBadge()
    }
    
    func setupBadge() {
        if cartProduct.count != 0 {
            guard let viewControllers = viewControllers else {return}
            for vc in viewControllers {
                if let cartVC = vc as? CartViewController {
                    cartVC.tabBarItem.badgeValue = String(cartProduct.count)
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
