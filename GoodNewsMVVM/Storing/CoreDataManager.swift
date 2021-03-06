//
//  CoreDataManager.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 08/03/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation
import CoreData


class CoreDataManager {
    private init() {    }
    
    static let shared = CoreDataManager ()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Const.persistentContainarName)
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("\(Const.persistentContainer) \(error)")
            }
        })
        return container
    }()
    
    func save() -> Bool {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do{
                try context.save()
                return true
            } catch{
                let nserror = error as NSError
                fatalError("\(Const.errorSaving) \(nserror)")
            }
        }
        
        return false
    }
    
     func fetch() -> [Qoute]{
        let request = Qoute.createFetchRequest()
        let order = NSSortDescriptor(key: "author", ascending: true)
        request.sortDescriptors = [order]
        do{
            let qList:[Qoute] = try self.mainContext.fetch(request) 
            return qList
        } catch {
            print("do fetch failed")
        }
        return [Qoute]()
     }
    
    func clearCoreData(list:[Qoute]) {
        do {
            for i in list {
                self.mainContext.delete(i)
            }
            try self.mainContext.save()
        } catch {
            print("could not delete")
        }
    }
}
