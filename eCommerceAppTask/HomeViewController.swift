//
//  ViewController.swift
//  eCommerceAppTask
//
//  Created by Sierra 4 on 13/02/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//
import CoreData
import ImageSlideshow
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var imageSlideShowOutlet: ImageSlideshow!
    
    @IBOutlet weak var collectionViewLevel1Outlet: UICollectionView!
    
    @IBOutlet weak var collectionViewLevel2Outlet: UICollectionView!

    //Dictionary to send data to detailview of product
    var dataToproductDetail = [String : String]()
    //selectedCategories Produc& price arrays if subcategories not exist
    var selectedCategoryProductsArray = [String]()
    var selectedCategoryProducPrice = [Float]()
    var selectedCategoryProductDesc = [String]()
    //selected parentId of category or subcategory & subcategory exist or not
    var selectedCategorySubCategoriesArray = [String]()
    var selectedCategorySubCategoryParentId = [Int]()
    
    var level1CategoriesFunctionCall = [String]()
    var level2CategoriesFunctionCall = [String]()
    var level2ParentIdFunctionCall = [Int64]()
    
    private let numberOfItemsPerRow: CGFloat = 4.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //imageSlider
        imageSlideShowOutlet.setImageInputs([ImageSource(image: UIImage(named: "levis")!),
                                             ImageSource(image: UIImage(named: "asus")!),
                                             ImageSource(image: UIImage(named: "moto1")!),
                                             ImageSource(image: UIImage(named: "moto2")!)])
        imageSlideShowOutlet.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        //level1 Categories Array
        level1CategoriesFunctionCall = CommonFunctions.categoriesArrayForLevel1()
        
        //level2 Categories Array
        level2CategoriesFunctionCall = CommonFunctions.categoriesArrayForLevel2().0
        level2ParentIdFunctionCall = CommonFunctions.categoriesArrayForLevel2().1
        
        //Navigatin bar color change
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        //collection number of cells
        let widthOfCollectionCell = (collectionViewLevel1Outlet.frame.width) / numberOfItemsPerRow
        let layout = collectionViewLevel1Outlet?.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = CGSize(width: widthOfCollectionCell, height: 90)
    }

    
    @IBAction func btnCart(_ sender: Any) {
        if CommonFunctions.fetchingDataFromCartTab().0.count == 0 {
            CommonFunctions.alertMessage(messageString: "Your cart is empty, Add some items", self)
        }
        else {
            performSegue(withIdentifier: "CartSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productDetailSegueFromHomeViewController" {
            let guest = segue.destination as! ProductDetailViewController
            guest.productName = dataToproductDetail["productName"]!
            guest.productDetails = dataToproductDetail["productDesc"]!
            guest.productPrice = dataToproductDetail["productPrice"]!
        } else if segue.identifier == "SubCategoriesTableViewController" {
            let guest = segue.destination as! SubCategoriesTableViewController
            guest.subCategoriesArray = selectedCategorySubCategoriesArray
            guest.subCategoryParentId = selectedCategorySubCategoryParentId                 
        } else if segue.identifier == "ProductsSegue" {
            let guest = segue.destination as! ProductsCollectionViewController
            guest.productName = selectedCategoryProductsArray
            guest.productPrice = selectedCategoryProducPrice
            guest.productDesc = selectedCategoryProductDesc
        }
    }
}
//MARK:- level 1, 2 CollectionView Delegates & Data Sources
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewLevel1Outlet {
            return level1CategoriesFunctionCall.count
        } else if collectionView == collectionViewLevel2Outlet {
            return level2CategoriesFunctionCall.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewLevel1Outlet {
            let cellLevel1 = collectionView.dequeueReusableCell(withReuseIdentifier: "Level1CollectionViewCell", for: indexPath) as! Level1CollectionViewCell
            cellLevel1.lblLevel1CategoriesOutlet.text = self.level1CategoriesFunctionCall[indexPath.row]
            return cellLevel1
        } else if collectionView == collectionViewLevel2Outlet{
            let cellLevel2 = collectionView.dequeueReusableCell(withReuseIdentifier: "Level2CollectionViewCell", for: indexPath) as! Level2CollectionViewCell
            cellLevel2.lblCollectionViewCategoriesOutsideLevel1.text = self.level2CategoriesFunctionCall[indexPath.row]
            return cellLevel2
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewLevel1Outlet {
            selectedCategorySubCategoriesArray = CommonFunctions.categoriesInsidecategory(parentId: 0, categoryName: level1CategoriesFunctionCall[indexPath.row]).1
            selectedCategorySubCategoryParentId = CommonFunctions.categoriesInsidecategory(parentId: 0, categoryName: level1CategoriesFunctionCall[indexPath.row]).0
            performSegue(withIdentifier: "SubCategoriesTableViewController", sender: self)
        } else if collectionView == collectionViewLevel2Outlet {
            
            if CommonFunctions.categoriesInsidecategory(parentId: level2ParentIdFunctionCall[indexPath.row], categoryName: level2CategoriesFunctionCall[indexPath.row]).1 != [] {
                selectedCategorySubCategoriesArray = CommonFunctions.categoriesInsidecategory(parentId: level2ParentIdFunctionCall[indexPath.row], categoryName: level2CategoriesFunctionCall[indexPath.row]).1
                selectedCategorySubCategoryParentId = CommonFunctions.categoriesInsidecategory(parentId: level2ParentIdFunctionCall[indexPath.row], categoryName: level2CategoriesFunctionCall[indexPath.row]).0
                performSegue(withIdentifier: "SubCategoriesTableViewController", sender: self)
            } else if CommonFunctions.productsOfACategory(parentId: level2ParentIdFunctionCall[indexPath.row]).0.count != 0 {
                selectedCategoryProductsArray = CommonFunctions.productsOfACategory(parentId: level2ParentIdFunctionCall[indexPath.row]).0
                selectedCategoryProducPrice = CommonFunctions.productsOfACategory(parentId: level2ParentIdFunctionCall[indexPath.row]).1
                selectedCategoryProductDesc = CommonFunctions.productsOfACategory(parentId: level2ParentIdFunctionCall[indexPath.row]).2
                performSegue(withIdentifier: "ProductsSegue", sender: self)
            }
            
        }
    }
}

//MARK:- TableView Delegates &  Data Sources
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommonFunctions.fetchingDataFromProductsTab().0.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTableViewCell", for: indexPath) as? ProductsTableViewCell else {
            fatalError()
        }
        cell.lblProductNameOutlet.text = CommonFunctions.fetchingDataFromProductsTab().1[indexPath.row]
        cell.lblProductDescriptionNameOutlet.text = CommonFunctions.fetchingDataFromProductsTab().3[indexPath.row]
        cell.lblProductPriceOutlet.text = String(CommonFunctions.fetchingDataFromProductsTab().2[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataToproductDetail["productName"] = CommonFunctions.fetchingDataFromProductsTab().1[indexPath.row]
        dataToproductDetail["productDesc"] = CommonFunctions.fetchingDataFromProductsTab().3[indexPath.row]
        dataToproductDetail["productPrice"] = String(CommonFunctions.fetchingDataFromProductsTab().2[indexPath.row])
        performSegue(withIdentifier: "productDetailSegueFromHomeViewController", sender: self)
    }
}
