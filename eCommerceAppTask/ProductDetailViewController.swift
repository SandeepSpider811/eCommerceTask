//
//  ProductDetailViewController.swift
//  eCommerceAppTask
//
//  Created by Sierra 4 on 15/02/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var lblProductNameOutlet: UILabel!
    
    @IBOutlet weak var lblproducDetailsOutlet: UILabel!
    
    @IBOutlet weak var lblProductpriceOutlet: UILabel!
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    
    var productName: String = ""
    var productDetails: String = ""
    var productPrice: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblProductNameOutlet.text = productName
        lblproducDetailsOutlet.text = productDetails
        lblProductpriceOutlet.text = "Rs. "+productPrice
        
        imageViewOutlet.layer.cornerRadius = 100
        imageViewOutlet.layer.borderWidth = 3
        imageViewOutlet.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    @IBAction func btnAddToCart(_ sender: Any) {
        CommonFunctions.insertIntoCartDB(name: productName, price: Float(productPrice)!, desc: productDetails)
        CommonFunctions.alertMessage(messageString: "what the heck, you just added a item to cart..", self)
    }
}
