//
//  UserDefaultsStore.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 05/03/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation

protocol UserDefaultsStoreProtocol {
    func checkIfEntryExist(name: String)
    func retriveData() -> (String, Int)
}

class UserDefaultsStore: UserDefaultsStoreProtocol {
    func checkIfEntryExist(name: String) {
        
    }
    
    func retriveData() -> (String, Int) {
        
        return ("", 0)
    }
}
