//
//  ListViewModel.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 11/03/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation

protocol ListViewModelProtocol: class {
    func refreshUI()
}
class ListViewModel {
    private var coreDataManager: CoreDataManager
    
    weak var delegate: ListViewModelProtocol?
    
    var user: User? {
        didSet{
            delegate?.refreshUI()
        }
    }
    
    init(user: User) {
        self.user = user
        self.coreDataManager = CoreDataManager.shared
    }
    
    func fetchList() {
        print("fetching list")
    }
    
    
}
