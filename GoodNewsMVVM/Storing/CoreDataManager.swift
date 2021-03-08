//
//  CoreDataManager.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 08/03/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func save ()
    func fetch ()
}

class CoreDataManager:  CoreDataManagerProtocol {
    func save() {
        print("do save")
    }
    
    func fetch() {
        print("do fetch")
    }
    
    
}
