//
//  CommonFunctions.swift
//  eCommerceAppTask
//
//  Created by Sierra 4 on 16/02/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//
import CoreData
import Foundation
import UIKit
class CommonFunctions {
    
    //Fetching data from Categories Tab
    class func fetchingDataFromCategoriesTab() -> ([Int64], [String], [Int64], [String]) {
        var categoriesArray = [String]()
        var categoryParentId = [Int64]()
        var categoryParentIdFull = [Int64]()
        var categoriesArrayFull = [String]()
        let fetchRequest: NSFetchRequest<CategoriesDB> = CategoriesDB.fetchRequest()
        do{
            let searchResults:[CategoriesDB] = try DatabaseController.getContext().fetch(fetchRequest)
            searchResults.enumerated().forEach{ index, result in
                categoryParentIdFull.append(result.parentId)
                categoriesArrayFull.append(result.title!)
                if index >= 1 {
                    categoriesArray.append(result.title!)
                    categoryParentId.append(result.parentId)
                }
            }
        } catch {
            print("Error in fetching")
        }
        return (categoryParentIdFull, categoriesArrayFull, categoryParentId, categoriesArray)
    }
    
    //Fetching data from products Tab
    class func fetchingDataFromProductsTab() -> ([Int64], [String], [Float], [String]) {
        var productsCategoryId = [Int64]()
        var productsDescription = [String]()
        var productName = [String]()
        var productPrice = [Float]()
        let fetchRequestForProductsTab: NSFetchRequest<ProductsDB> = ProductsDB.fetchRequest()
        do{
            let searchResults = try DatabaseController.getContext().fetch(fetchRequestForProductsTab)
            for result in searchResults as [ProductsDB] {
                productsCategoryId.append(result.categoryId)
                productName.append(result.productName!)
                productPrice.append(result.productPrice)
                productsDescription.append(result.productDesc!)
            }
        } catch {
            print("Error in fetching")
        }
        return (productsCategoryId, productName, productPrice, productsDescription)
    }
    
    //returning products of a category
    class func productsOfACategory(parentId: Int64) -> ([String], [Float],[String]){
        var productsArray = [String]()
        var productsPriceArray = [Float]()
        var productsDescArray = [String]()
        for index in 0..<self.fetchingDataFromProductsTab().0.count{
            if parentId == self.fetchingDataFromProductsTab().0[index] {
                productsArray.append(self.fetchingDataFromProductsTab().1[index])
                productsPriceArray.append(self.fetchingDataFromProductsTab().2[index])
                productsDescArray.append(self.fetchingDataFromProductsTab().3[index])
            }
        }
        return(productsArray, productsPriceArray, productsDescArray)
    }

    //check subcategory exist or not
    class func categoriesInsidecategory(parentId: Int64, categoryName: String) -> ([Int], [String]) {
        var subCategoriesArray = [String]()
        var subCategoriesParentIdArray = [Int]()
        var idOfSelectedCategory: Int = 0
        for index in 0..<self.fetchingDataFromCategoriesTab().0.count {
            if self.fetchingDataFromCategoriesTab().0[index] == parentId && categoryName == self.fetchingDataFromCategoriesTab().1[index]{
                idOfSelectedCategory = index
                for index in 0..<self.fetchingDataFromCategoriesTab().1.count {
                    if Int(self.fetchingDataFromCategoriesTab().0[index]) ==  idOfSelectedCategory{
                        subCategoriesArray.append(self.fetchingDataFromCategoriesTab().1[index])
                        subCategoriesParentIdArray.append(Int(self.fetchingDataFromCategoriesTab().0[index]))
                    }
                }
            }
        }
        return (subCategoriesParentIdArray, subCategoriesArray)
    }
    
    //category arrays for level 1
    class func categoriesArrayForLevel1() -> [String] {
        var level1Categories = [String]()
        for index in 0..<self.fetchingDataFromCategoriesTab().2.count {
            if self.fetchingDataFromCategoriesTab().2[index] == 0 {
                level1Categories.append(self.fetchingDataFromCategoriesTab().3[index])
            }
        }
        return level1Categories
    }
    
    //Categories Array for level 2
    class func categoriesArrayForLevel2() -> ([String], [Int64]) {
        var level2Categories = [String]()
        var level2ParentId = [Int64]()
        for index in 0..<self.fetchingDataFromCategoriesTab().2.count {
            if self.fetchingDataFromCategoriesTab().2[index] > 0 {
                level2Categories.append(self.fetchingDataFromCategoriesTab().3[index])
                level2ParentId.append(self.fetchingDataFromCategoriesTab().2[index])
            }
        }
        return (level2Categories, level2ParentId)
    }
    
    //Inserting data into Cart
    class func insertIntoCartDB(name: String, price: Float, desc: String){
        let cartObj: CartDB = NSEntityDescription.insertNewObject(forEntityName: "CartDB", into: DatabaseController.getContext()) as! CartDB
        cartObj.productName = name
        cartObj.productDesc = desc
        cartObj.productPrice = price
        DatabaseController.saveContext()
    }
    
    //Fetching data from products Tab
    class func fetchingDataFromCartTab() -> ([String], [String], [Float]) {
        var productsDescription = [String]()
        var productName = [String]()
        var productPrice = [Float]()
        let fetchRequestForCartTab: NSFetchRequest<CartDB> = CartDB.fetchRequest()
        do{
            let searchResults = try DatabaseController.getContext().fetch(fetchRequestForCartTab)
            for result in searchResults as [CartDB] {
                productName.append(result.productName!)
                productPrice.append(result.productPrice)
                productsDescription.append(result.productDesc!)
            }
        } catch {
            print("Error in fetching")
        }
        return (productName, productsDescription, productPrice)
    }
    
    class func deleteProductFromCart(index: Int) {
        let fetchRequestForCartTab: NSFetchRequest<CartDB> = CartDB.fetchRequest()
        do {
            let results = try DatabaseController.getContext().fetch(fetchRequestForCartTab)
            let task = results[index]
            DatabaseController.getContext().delete(task)
            do {
                try DatabaseController.getContext().save()
                print("Item deleted")
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    //Alert Message
    class func alertMessage(messageString: String, _ selfArg: UIViewController) {
        let alert = UIAlertController(title: "Oops!", message: messageString, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive, handler: {(action:UIAlertAction!) in print("you have pressed the Cancel button")
        }))
        selfArg.present(alert, animated: true, completion: nil)
    }

    //getting products Array for sub Categories
    class func returningProdArrays(prodCatName: String) -> ([String],[String],[Float]) {
        var prodId: Int64 = 0
        var prodNames = [String]()
        var prodDescs = [String]()
        var prodPrices = [Float]()
        
        for index in 0..<fetchingDataFromCategoriesTab().2.count {
            if prodCatName == fetchingDataFromCategoriesTab().3[index] {
                prodId = fetchingDataFromCategoriesTab().2[index]
            }
        }
        if prodId != 0 {
            for index in 0..<fetchingDataFromProductsTab().0.count {
                if prodId == fetchingDataFromProductsTab().0[index] {
                    prodNames.append(fetchingDataFromProductsTab().1[index])
                    prodPrices.append(fetchingDataFromProductsTab().2[index])
                    prodDescs.append(fetchingDataFromProductsTab().3[index])
                }
            }
        }
        return (prodNames, prodDescs, prodPrices)
    }
    
}
