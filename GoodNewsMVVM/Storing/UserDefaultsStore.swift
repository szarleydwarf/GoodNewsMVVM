//
//  UserDefaultsStore.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 05/03/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation

protocol UserDefaultsStoreProtocol {
    func fetchUser() -> User
    func saveUser(user:User)
    func updateUser(bookmarkCount: Int)
    func deleteData ()
}

class UserDefaultsStore: UserDefaultsStoreProtocol {
    private let userDefaults = UserDefaults.standard
    
    func fetchUser() -> User {
        var user: User = User(name: "", bookmarkCounts: 0, qouteList: nil)
        if let userName = self.userDefaults.string(forKey: Const.name) {
            user.name = userName
        }
        user.bookmarkCounts = self.userDefaults.integer(forKey: Const.bookmarksCount)
        return user
    }
    
    func saveUser (user: User) {
        self.userDefaults.setValue(user.name, forKey: Const.name)
        self.userDefaults.set(user.bookmarkCounts, forKey: Const.bookmarksCount)
    }
    
    func updateUser(bookmarkCount: Int) {
        self.userDefaults.set(bookmarkCount, forKey: Const.bookmarksCount)
    }

    func deleteData () {
        self.userDefaults.setValue(nil, forKey: Const.name)
        self.userDefaults.set(0, forKey: Const.bookmarksCount)
    }
}
