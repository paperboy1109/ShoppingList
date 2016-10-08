//
//  ShoppingItem+CoreDataProperties.swift
//  ShoppingList
//
//  Created by Daniel J Janiak on 10/8/16.
//  Copyright © 2016 redwoodempiredev. All rights reserved.
//

import Foundation
import CoreData


extension ShoppingItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingItem> {
        return NSFetchRequest<ShoppingItem>(entityName: "ShoppingItem");
    }

    @NSManaged public var name: String?

}
