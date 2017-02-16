//
//  CategoriesDB+CoreDataProperties.swift
//  eCommerceAppTask
//
//  Created by Sierra 4 on 14/02/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//

import Foundation
import CoreData


extension CategoriesDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoriesDB> {
        return NSFetchRequest<CategoriesDB>(entityName: "CategoriesDB");
    }

    @NSManaged public var parentId: Int64
    @NSManaged public var title: String?

}
