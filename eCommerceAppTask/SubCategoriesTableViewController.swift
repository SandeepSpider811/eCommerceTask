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
    
    var objHomeViewController = HomeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tempSubCatArray = objHomeViewController.categoriesInsidecategory(parentId: 0, categoryName: "Electronics").1
//        print(tempSubCatArray)
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
//        tempSubCatArray = objHomeViewController.categoriesInsidecategory(parentId: Int64(subCategoryParentId[indexPath.row]), categoryName: subCategoriesArray[indexPath.row]).1
//        tempSubCatParentIdArray = objHomeViewController.categoriesInsidecategory(parentId: Int64(subCategoryParentId[indexPath.row]), categoryName: subCategoriesArray[indexPath.row]).0
    }
}
