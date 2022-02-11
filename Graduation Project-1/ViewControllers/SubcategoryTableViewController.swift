//
//  SubcategoryTableViewControllerTableViewController.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 19.01.2022.
//

import UIKit

class SubcategoryTableViewController: UITableViewController {
    
    var subCategories: [Subcategories] = []

    override func viewDidLoad() {
        tableView.rowHeight = 50
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subCategories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCell", for: indexPath)
        let category = subCategories[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = category.name
        content.imageProperties.tintColor = .black
        content.image = ImageManager.shared.fetchImage(from: category.iconImage)
        cell.contentConfiguration = content
        return cell
    }
    
    // MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let subCategory = subCategories[indexPath.row]
        guard let productVC = storyboard?.instantiateViewController(withIdentifier: "ProductsVC") as? ProductsCollectionViewController else {return}
        productVC.title = subCategory.name
        productVC.categoryId = subCategory.id
        navigationController?.pushViewController(productVC, animated: true)
    }
}
