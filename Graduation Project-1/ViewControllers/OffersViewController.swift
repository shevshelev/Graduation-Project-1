//
//  OffersViewController.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 28.01.2022.
//

import UIKit
import RealmSwift

class OffersViewController: UIViewController {
    
    @IBOutlet var tabelView: UITableView!
    
    private var cartProduct: Results<Product>!
    
    var product: Product = Product()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.layer.cornerRadius = 20
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.removeFromSuperview()
    }
    
    private func createProduct(_ offer: Offer) -> Product {
        let product = product
        product.offer = offer
        return product
    }
}

extension OffersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        product.offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let offer = product.offers[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "offerCell") as? OfferTableViewCell else {return UITableViewCell()}
        cell.setupCell(offer: offer)
        return cell
    }
}

extension OffersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let offer = product.offers[indexPath.row]
        let product = createProduct(offer)
        RealmPersistentManager.shared.save(product)
        cartProduct = RealmPersistentManager.shared.realm.objects(Product.self)
        
        if let viewControllers = tabBarController?.viewControllers {
            for vc in viewControllers {
                if let cartVc = vc as? CartViewController {
                    cartVc.tabBarItem.badgeValue = String(cartProduct.count)
                }
            }
        }
        view.removeFromSuperview()
    }
}
