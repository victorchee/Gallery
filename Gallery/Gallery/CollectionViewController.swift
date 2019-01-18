//
//  CollectionViewController.swift
//  Gallery
//
//  Created by Migu on 2019/1/18.
//  Copyright © 2019 VIctorChee. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    private let images = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5")]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
    
        // Configure the cell
        cell.imageView.image = images[indexPath.item]
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let destination = storyboard?.instantiateViewController(withIdentifier: "GalleryViewController") as? GalleryViewController else { return }
        destination.images = images
        destination.selectedIndex = indexPath.item
        present(destination, animated: true)
    }

}
