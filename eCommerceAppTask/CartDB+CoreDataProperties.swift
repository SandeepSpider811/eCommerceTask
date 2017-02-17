//
//  CartDB+CoreDataProperties.swift
//  eCommerceAppTask
//
//  Created by Sierra 4 on 17/02/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//

import Foundation
import CoreData


extension CartDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartDB> {
        return NSFetchRequest<CartDB>(entityName: "CartDB");
    }

    @NSManaged public var productName: String?
    @NSManaged public var productDesc: String?
    @NSManaged public var productPrice: Float

}
