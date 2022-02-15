//
//  CartViewController.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 03.02.2022.
//

import UIKit

protocol DeleteProductViewControllerDelegate {
    func updateView()
}

class CartViewController: UIViewController {
    
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var button: UIButton!
    @IBOutlet var tableView: UITableView!
    
    private var cartProducts = RealmPersistentManager.shared.getProducts()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    @IBAction func buttonPressed() {
        if cartProducts.count == 0 {
            if let viewControllers = tabBarController?.viewControllers {
                for vc in viewControllers {
                    if let mainVC = vc as? UINavigationController {
                        mainVC.popToRootViewController(animated: false)
                        tabBarController?.selectedViewController = mainVC
                    }
                }
            }
        } else {
            RealmPersistentManager.shared.deleteAll()
            setupViews()
            print("Заказали")
        }
    }
    
    @IBAction func trashButtonPressed(_ sender: UIButton) {
        guard let deleteVC = storyboard?.instantiateViewController(withIdentifier: "deleteVC") as? DeleteProductViewController else {return}
        deleteVC.product = cartProducts[sender.tag]
        deleteVC.delegate = self
        
        self.addChild(deleteVC)
        deleteVC.view.frame = self.view.frame
        self.view.addSubview(deleteVC.view)
        deleteVC.didMove(toParent: self)
    }
    
    private func setupViews() {
        var totalSum: Double = 0
        var orderedAmount = 0
        
        for product in cartProducts {
            guard let price = Double(product.price) else {return}
            totalSum = totalSum + price * Double(product.orderedAmount ?? 0)
        }
        if cartProducts.count != 0 {
            for product in cartProducts {
                guard let amount = product.orderedAmount else {return}
                orderedAmount = orderedAmount + amount
            }
            tabBarItem.badgeValue = String(orderedAmount)
        } else {
            tabBarItem.badgeValue = nil
        }
        
        
        tableView.reloadData()
        priceLabel.text = "\(totalSum) руб."
        button.setTitle(
            cartProducts.count == 0
            ? "На главную"
            : "Оформить заказ",
            for: .normal
        )
    }
}

// MARK: - UITableViewDataSource

extension CartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartProductTableViewCell else {return UITableViewCell()}
        let product = cartProducts[indexPath.row]
        cell.trashButton.tag = indexPath.row
        cell.setupCell(product)
        return cell
    }
}

// MARK: - DeleteProductViewControllerDelegate

extension CartViewController: DeleteProductViewControllerDelegate {
    func updateView() {
        self.setupViews()
    }
}
