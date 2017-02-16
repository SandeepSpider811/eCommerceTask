//
//  ProductsDB+CoreDataProperties.swift
//  eCommerceAppTask
//
//  Created by Sierra 4 on 14/02/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//

import Foundation
import CoreData


extension ProductsDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductsDB> {
        return NSFetchRequest<ProductsDB>(entityName: "ProductsDB");
    }

    @NSManaged public var categoryId: Int64
    @NSManaged public var productName: String?
    @NSManaged public var productPrice: Float
    @NSManaged public var productDesc: String?

}
