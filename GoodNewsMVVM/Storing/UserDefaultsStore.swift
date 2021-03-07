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
    func fetchUser() -> User
    func saveUser(user:User)
    func updateUser(bookmarkCount: Int)
}

class UserDefaultsStore: UserDefaultsStoreProtocol {
    private let userDefaults = UserDefaults.standard
    
    func checkIfEntryExist() -> Bool {
        
        return false
    }
    
    func fetchUser() -> User {
        var user: User = User(name: "", bookmarkCounts: 0)
        if let userName = self.userDefaults.string(forKey: Const.name) {
            user.name = userName
        }
        user.bookmarkCounts = self.userDefaults.integer(forKey: Const.bookmarksCount)
        print("FETCHING USER >> \(user.name) >> \(user.bookmarkCounts) << ")
        return user
    }
    
    func saveUser (user: User) {
        self.userDefaults.setValue(user.name, forKey: Const.name)
        self.userDefaults.set(user.bookmarkCounts, forKey: Const.bookmarksCount)
    }
    
    func updateUser(bookmarkCount: Int) {
        self.userDefaults.set(bookmarkCount, forKey: Const.bookmarksCount)
    }

}
