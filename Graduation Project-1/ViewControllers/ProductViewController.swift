//
//  ProductViewController.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 28.01.2022.
//

import UIKit

class ProductViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var product = Product()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func backButtonPressed() {
        navigationController?.popViewController(animated: true)
        navigationController?.isNavigationBarHidden.toggle()
    }
    
    @IBAction func offersButtonPressed(_ sender: Any) {
        guard let offerVC = storyboard?.instantiateViewController(withIdentifier: "offersVC") as? OffersViewController else {return}
        offerVC.product = product
        self.addChild(offerVC)
        offerVC.view.frame = self.view.frame
        self.view.addSubview(offerVC.view)
        offerVC.didMove(toParent: self)
    }
    
    @IBAction func cartButtonPressed(_ sender: Any) {
        if let viewControllers = tabBarController?.viewControllers {
            for vc in viewControllers {
                if let cartVc = vc as? CartViewController {
                    tabBarController?.selectedViewController = cartVc
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ProductViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "productImagesCell") as? ProductImageTableViewCell else {return UITableViewCell()}
            cell.pageControl.numberOfPages = product.productImages.count
            cell.images = product.productImages
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "productNameCell") as? ProductNameTableViewCell else {return UITableViewCell()}
            cell.setupCell(product: product)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell") else {return UITableViewCell()}
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as? ProductDescriptionTableViewCell else {return UITableViewCell()}
            cell.descriptionLabel.text = product.productDescription
            return cell
        default:
            return UITableViewCell()
        }
    }
}
