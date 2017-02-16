//
//  ProductsCollectionViewController.swift
//  eCommerceAppTask
//
//  Created by Sierra 4 on 16/02/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//

import UIKit

class ProductsCollectionViewController: UICollectionViewController {
    
    var productName = [String]()
    var productPrice = [Float]()
    var productDesc = [String]()
    var dataToproductDetail = [String : String]()
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return productName.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCollectionViewCell", for: indexPath) as! ProductsCollectionViewCell
        cell.lblProductNameOutlet.text = productName[indexPath.row]
        cell.lblProductPriceOutlet.text = "Rs. " + String(productPrice[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dataToproductDetail["productName"] = productName[indexPath.row]
        dataToproductDetail["productDesc"] = productDesc[indexPath.row]
        dataToproductDetail["productPrice"] = String(productPrice[indexPath.row])
        performSegue(withIdentifier: "productDeatilFromProductsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productDeatilFromProductsSegue" {
            let guest = segue.destination as! ProductDetailViewController
            guest.productName = dataToproductDetail["productName"]!
            guest.productDetails = dataToproductDetail["productDesc"]!
            guest.productPrice = dataToproductDetail["productPrice"]!
        }
    }
}
