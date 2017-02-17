//
//  SubCategoriesTableViewController.swift
//  eCommerceAppTask
//
//  Created by Sierra 4 on 15/02/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//

import UIKit

class SubCategoriesTableViewController: UITableViewController {
    
    var subCategoriesArray = [String]()
    var subCategoryParentId = [Int]()
    
    var tempSubCatArray = [String]()
    var tempSubCatParentIdArray = [Int]()
    
    //selectedCategories Produc& price arrays if subcategories not exist
    var selectedCategoryProductsArray = [String]()
    var selectedCategoryProductPrice = [Float]()
    var selectedCategoryProductDesc = [String]()
    
    var level2ParentIdFunctionCall = [Int64]() //parent id for products
    override func viewDidLoad() {
        super.viewDidLoad()
        print(CommonFunctions.fetchingDataFromCategoriesTab().2)
        print(CommonFunctions.fetchingDataFromCategoriesTab().3)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategoriesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategoriestableViewCell", for: indexPath) as? SubCategoriestableViewCell else {
            fatalError()
        }
        cell.lblCategoryNamesOutlet.text = subCategoriesArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tempSubCatArray = CommonFunctions.categoriesInsidecategory(parentId: Int64(subCategoryParentId[indexPath.row]), categoryName: subCategoriesArray[indexPath.row]).1
        tempSubCatParentIdArray = CommonFunctions.categoriesInsidecategory(parentId: Int64(subCategoryParentId[indexPath.row]), categoryName: subCategoriesArray[indexPath.row]).0
        if tempSubCatArray == [] {
            selectedCategoryProductsArray = CommonFunctions.returningProdArrays(prodCatName: subCategoriesArray[indexPath.row]).0
            selectedCategoryProductDesc = CommonFunctions.returningProdArrays(prodCatName: subCategoriesArray[indexPath.row]).1
            selectedCategoryProductPrice = CommonFunctions.returningProdArrays(prodCatName: subCategoriesArray[indexPath.row]).2
            print(subCategoriesArray[indexPath.row])
            if selectedCategoryProductDesc.count != 0 {
                performSegue(withIdentifier: "subCategoryToProducts", sender: self)
            }
        } else {
            subCategoriesArray = tempSubCatArray
            subCategoryParentId = tempSubCatParentIdArray
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "subCategoryToProducts" {
            let guest = segue.destination as! ProductsCollectionViewController
            guest.productName = selectedCategoryProductsArray
            guest.productPrice = selectedCategoryProductPrice
            guest.productDesc = selectedCategoryProductDesc
        }
    }
}
