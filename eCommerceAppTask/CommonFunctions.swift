//
//  CommonFunctions.swift
//  eCommerceAppTask
//
//  Created by Sierra 4 on 16/02/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//
import CoreData
import Foundation

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
        print("Inside Func \(parentId) \(categoryName)")
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
}
