//
//  ProductsCollectionViewController.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 19.01.2022.
//

import UIKit

class ProductsCollectionViewController: UICollectionViewController {
    
    var categoryId: Int = 0
    var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        let activityIndicator = showActivity(in: view)
        NetworkManager.shared.fetchProducts(productId: categoryId) { result in
            switch result {
            case .success(let arrayOfProducts):
                DispatchQueue.main.async {
                    for (_, product) in arrayOfProducts {
                        self.products.append(product)
                    }
                    self.products = self.products.sorted()
                    self.collectionView.reloadData()
                    activityIndicator.stopAnimating()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = collectionView.indexPathsForSelectedItems else {return}
        let product = products[indexPath[0].item]
        guard let productVC = segue.destination as? ProductViewController else {return}
        productVC.product = product
    }
    
    private func showActivity(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        return activityIndicator
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
        let product = products[indexPath.item]
        cell.setupCell(product)
        return cell
    }

}

// MARK: UICollectionViewDelegateFlowLayout

extension ProductsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = UIScreen.main.bounds.width / 2 - 5
        let h = UIScreen.main.bounds.height / 3 - 8
        return CGSize(width: w, height: h)
    }
}
