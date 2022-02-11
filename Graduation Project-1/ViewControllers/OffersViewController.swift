//
//  OffersViewController.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 28.01.2022.
//

import UIKit

class OffersViewController: UIViewController {
    
    @IBOutlet var tabelView: UITableView!
    
    private var cartProduct = RealmPersistentManager.shared.getProducts()
    
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

// MARK: - UITableViewDataSource

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

// MARK: - UITableViewDelegate

extension OffersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let offer = product.offers[indexPath.row]
        let product = createProduct(offer)
        RealmPersistentManager.shared.save(product)
        
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
