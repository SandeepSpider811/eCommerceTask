//
//  AddProductViewController.swift
//  eCommerceAppTask
//
//  Created by Sierra 4 on 13/02/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//
import CoreData
import UIKit

class AddProductViewController: UIViewController {
    
    @IBOutlet weak var txtFieldProductNameOutlet: UITextField!
    
    @IBOutlet weak var txtFieldCategoryNameOutlet: UITextField!
    
    @IBOutlet weak var txtFieldProductPriceOutlet: UITextField!
    
    @IBOutlet weak var txtViewProductDescriptionOutlet: UITextView!
    
    var productName: String = ""
    var categoryName: String = ""
    var productPrice: Float = 0.0
    var productDescription: String = ""
    
    var categoriesArray = [String]()
    var categoryParentId = [Int64]()
    
    let categoryPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFieldProductNameOutlet.delegate = self
        txtFieldCategoryNameOutlet.delegate = self
        txtFieldProductPriceOutlet.delegate = self
        txtViewProductDescriptionOutlet.delegate = self
        categoryPicker.delegate = self
        txtFieldCategoryNameOutlet.inputView = categoryPicker
        //Fetching Data from CategoriesDB
        let fetchRequest: NSFetchRequest<CategoriesDB> = CategoriesDB.fetchRequest()
        do{
            let searchResults:[CategoriesDB] = try DatabaseController.getContext().fetch(fetchRequest)
            searchResults.enumerated().forEach{ index, result in
                if index >= 1 {
                    categoriesArray.append(result.title!)
                    categoryParentId.append(result.parentId)
                }
            }
            print(categoriesArray)
            print(categoryParentId)
        } catch {
            print("Error in fetching")
        }
    }
    
    @IBAction func btnAddProductAction(_ sender: Any) {
        productName = txtFieldProductNameOutlet.text!
        categoryName = txtFieldCategoryNameOutlet.text!
        productDescription = txtViewProductDescriptionOutlet.text!
        var selectedCategoryIdIndex: Int = 0
        var selectedCategoryId: Int64 = 0
        if productName == "" || categoryName == "" || productDescription == "" || txtFieldProductPriceOutlet.text == "" {
            CommonFunctions.alertMessage(messageString: "Something gone wrong", self)
        } else {
            productPrice = Float(txtFieldProductPriceOutlet.text!)!
            for cat in categoriesArray {
                if txtFieldCategoryNameOutlet.text == cat {
                    selectedCategoryIdIndex = categoriesArray.index(of: txtFieldCategoryNameOutlet.text!)!
                    selectedCategoryId = categoryParentId[selectedCategoryIdIndex]
                }
            }
            let productDBObj: ProductsDB = NSEntityDescription.insertNewObject(forEntityName: "ProductsDB", into: DatabaseController.getContext()) as! ProductsDB
            productDBObj.productName = productName
            productDBObj.productPrice = productPrice
            productDBObj.productDesc = productDescription
            productDBObj.categoryId = selectedCategoryId
            DatabaseController.saveContext()
            CommonFunctions.alertMessage(messageString: "You just added  \(productName)", self)
            //output try
            let fetchRequest: NSFetchRequest<ProductsDB> = ProductsDB.fetchRequest()
            do{
                let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
                for result in searchResults as [ProductsDB] {
                    print("catID: \(result.categoryId)\nproductName: \(result.productName)\nproductPrice: \(result.productPrice)\nproductDesc: \(result.productDesc)")
                }
            } catch {
                print("Error in fetching")
            }
        }
    }
    
}
//MARK:- TextField & TextView Delgates
extension AddProductViewController: UITextFieldDelegate, UITextViewDelegate {
    //touch anywhere to remove keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == UIReturnKeyType.default {
            textField.returnKeyType = UIReturnKeyType.next
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtFieldProductNameOutlet {
            self.txtFieldCategoryNameOutlet.becomeFirstResponder()
        } else if textField == self.txtFieldCategoryNameOutlet {
            self.txtFieldProductPriceOutlet.becomeFirstResponder()
        } else if textField == self.txtFieldProductPriceOutlet {
            self.txtViewProductDescriptionOutlet.becomeFirstResponder()
        }
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
//MARK:- Pickerview Delgates & DataSource
extension AddProductViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoriesArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoriesArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtFieldCategoryNameOutlet.text = categoriesArray[row]
    }
}
