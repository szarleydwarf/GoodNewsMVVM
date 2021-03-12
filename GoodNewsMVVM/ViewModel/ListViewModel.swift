//
//  ListViewModel.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 11/03/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation

protocol ListViewModelProtocol: class {
    func refreshLabel()
}
class ListViewModel {
    private var coreDataManager: CoreDataManager
    
    weak var delegate: ListViewModelProtocol?
    
    var user: User?
    var quotesList:[Qoute]?
    
    init(user:User, coreData:CoreDataManager = CoreDataManager.shared) {
        self.user = user
        self.coreDataManager = coreData
    }
    
    func fetchList() {
        print("fetching list")
        self.quotesList = self.coreDataManager.fetch()
    }
    
    
    
}
