//
//  Qoute+CoreDataProperties.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 09/03/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//
//

import Foundation
import CoreData


extension Qoute {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Qoute> {
        return NSFetchRequest<Qoute>(entityName: "Qoute")
    }

    @NSManaged public var author: String
    @NSManaged public var text: String

}

