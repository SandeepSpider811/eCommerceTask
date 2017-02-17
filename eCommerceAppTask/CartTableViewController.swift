//
//  CartTableViewController.swift
//  eCommerceAppTask
//
//  Created by Sierra 4 on 17/02/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//

import UIKit

class CartTableViewController: UITableViewController {
    
    var productNames = [String]()
    var productDescs = [String]()
    var productPrices = [Float]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productNames = CommonFunctions.fetchingDataFromCartTab().0
        productDescs = CommonFunctions.fetchingDataFromCartTab().1
        productPrices = CommonFunctions.fetchingDataFromCartTab().2
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as? CartTableViewCell else {
            fatalError()
        }
        cell.productName.text = productNames[indexPath.row]
        cell.productDesc.text = productDescs[indexPath.row]
        cell.productPrice.text = "Rs. " + String(productPrices[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            CommonFunctions.deleteProductFromCart(index: indexPath.row)
            
            productNames = CommonFunctions.fetchingDataFromCartTab().0
            productDescs = CommonFunctions.fetchingDataFromCartTab().1
            productPrices = CommonFunctions.fetchingDataFromCartTab().2
            self.tableView.reloadData()
        }
    }
}
