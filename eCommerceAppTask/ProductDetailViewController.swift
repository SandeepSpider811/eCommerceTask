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
    
    var productName: String = ""
    var productDetails: String = ""
    var productPrice: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblProductNameOutlet.text = productName
        lblproducDetailsOutlet.text = productDetails
        lblProductpriceOutlet.text = "Rs. "+productPrice
    }

}
