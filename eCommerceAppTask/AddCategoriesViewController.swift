//
//  AddCategoriesViewController.swift
//  eCommerceAppTask
//
//  Created by Sierra 4 on 13/02/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//
import CoreData
import UIKit

class AddCategoriesViewController: UIViewController {
    
    @IBOutlet weak var txtFieldCategoryNameOutlet: UITextField!
    
    @IBOutlet weak var txtFieldCategoryTypeOutlet: UITextField!
    
    let categoryPicker = UIPickerView()
    
    var categoriesArray = [String]()
    
    var parentIdDefault = 0
    
    var categoryName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFieldCategoryNameOutlet.delegate = self
        txtFieldCategoryTypeOutlet.delegate = self
        categoryPicker.delegate = self
        txtFieldCategoryTypeOutlet.inputView = categoryPicker
        
        //Fetching Data from CategoriesDB
        let fetchRequest: NSFetchRequest<CategoriesDB> = CategoriesDB.fetchRequest()
        do{
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            for result in searchResults as [CategoriesDB] {
                categoriesArray.append(result.title!)
                print("Category: \(result.title) pID: \(result.parentId)")
//                DatabaseController.getContext().delete(result) //deleting data
//                DatabaseController.saveContext()
            }
        } catch {
            print("Error in fetching")
        }
    }
    
    @IBAction func btnAddCategoryAction(_ sender: Any) {
        
        categoryName = txtFieldCategoryNameOutlet.text!
        if categoryName == "" || txtFieldCategoryTypeOutlet.text == "" {
            CommonFunctions.alertMessage(messageString: "Something gone wrong", self)
        } else if txtFieldCategoryTypeOutlet.text == "New Category" {
            parentIdDefault = 0
            insertIntoCoreData()
        } else {
            for cat in categoriesArray {
                if txtFieldCategoryTypeOutlet.text == cat {
                    parentIdDefault = categoriesArray.index(of: txtFieldCategoryTypeOutlet.text!)!
                }
            }
            insertIntoCoreData()
        }
    }
    
    //Insertion function CoreData
    func insertIntoCoreData(){
        let catgoriesObj: CategoriesDB = NSEntityDescription.insertNewObject(forEntityName: "CategoriesDB", into: DatabaseController.getContext()) as! CategoriesDB
        catgoriesObj.title = categoryName
        catgoriesObj.parentId = Int64(parentIdDefault)
        DatabaseController.saveContext()
    }
}
//MARK:- TextField Delegates
extension AddCategoriesViewController: UITextFieldDelegate {
    //touch anywhere to remove keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.txtFieldCategoryNameOutlet {
            textField.returnKeyType = UIReturnKeyType.next
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtFieldCategoryNameOutlet {
            self.txtFieldCategoryTypeOutlet.becomeFirstResponder()
        }
        return true
    }
}
//MARK:- Pickerview Delgates & DataSource
extension AddCategoriesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        txtFieldCategoryTypeOutlet.text = categoriesArray[row]
    }
}
