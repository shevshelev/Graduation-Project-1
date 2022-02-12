//
//  ProductImageTableViewCell.swift
//  Graduation Project-1
//
//  Created by Shevshelev Lev on 28.01.2022.
//

import UIKit
import RealmSwift


class ProductImageTableViewCell: UITableViewCell {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    
    
    var images = List<ProductImage>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        pageControl.hidesForSinglePage = true
    }
}

extension ProductImageTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesCell", for: indexPath) as? ProductImagesCollectionViewCell else {return UICollectionViewCell()}
        cell.productImageView.image =  ImageManager.shared.fetchImage(from: images[indexPath.section].imageURL)
        return cell
    }
}

extension ProductImageTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = UIScreen.main.bounds.width
        let h = w / 1.5
        return CGSize(width: w, height: h)
    }
}

extension ProductImageTableViewCell {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(collectionView.contentOffset.x / contentView.frame.width)
        pageControl.currentPage = Int(pageNumber)
    }
}

