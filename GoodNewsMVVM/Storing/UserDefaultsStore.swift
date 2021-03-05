//
//  UserDefaultsStore.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 05/03/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation

protocol UserDefaultsStoreProtocol {
    func checkIfEntryExist() -> Bool
    func retriveData() -> (String, Int)
}

class UserDefaultsStore: UserDefaultsStoreProtocol {
    private let userDefaults = UserDefaults.standard
    
    func checkIfEntryExist() -> Bool {
        
        return false
    }
    
    func retriveData() -> (String, Int) {
        let name = self.userDefaults.string(forKey: Const.name)
        
        let count = self.userDefaults.integer(forKey: Const.bookmarksCount)
        print("NAME \(name) >> \(count) << ")
        return ("", 0)
    }
}
