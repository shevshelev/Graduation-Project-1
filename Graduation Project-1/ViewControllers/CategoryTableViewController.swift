//
//  СategoryTableViewController.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 18.01.2022.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    private let urlString = "https://blackstarshop.ru/index.php?route=api/v1/categories"
    private var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let activityIndicator = showActivity(in: view)
        NetworkManager.shared.fetchCategory(urlString: urlString) { results in
            switch results{
            case .success(let result):
                DispatchQueue.main.async {
                    self.categories = result.sorted()
                    self.tableView.reloadData()
                    activityIndicator.stopAnimating()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        navigationController?.isToolbarHidden = true
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
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CategoryTableViewCell else {return UITableViewCell()}
        let category = categories[indexPath.row]
        cell.setupCell(category)
        return cell
    }
    
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let category = categories[indexPath.row]
        if !category.subcategories.isEmpty {
        guard let subCatVC = storyboard?.instantiateViewController(withIdentifier: "SubcategoryVC") as? SubcategoryTableViewController else {return}
            subCatVC.title = category.name
            subCatVC.subCategories = category.subcategories.sorted()
        navigationController?.pushViewController(subCatVC, animated: true)
        } else {
            guard let prodVC = storyboard?.instantiateViewController(withIdentifier: "ProductsVC") as? ProductsCollectionViewController else {return}
            prodVC.title = category.name
            prodVC.categoryId = category.id
            navigationController?.pushViewController(prodVC, animated: true)
        }
    }
}
