//
//  DeleteProductViewController.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 04.02.2022.
//

import UIKit

class DeleteProductViewController: UIViewController {
    
    @IBOutlet var subView: UIView!
    
    var product = Product()
    var delegate: DeleteProductViewControllerDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subView.layer.cornerRadius = 10
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    @IBAction func yesButtonPressed() {
//        guard let cartVC = storyboard?.instantiateViewController(withIdentifier: "cartVC") as? CartViewController else {return}
        RealmPersistentManager.shared.delete(product)
//        cartVC.cartProducts = RealmPersistentManager.shared.realm.objects(Product.self)
        delegate.updateView()
        view.removeFromSuperview()
    }
    @IBAction func noButtonPressed() {
        view.removeFromSuperview()
    }
    
    
}
