//
//  ListViewModel.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 11/03/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation

protocol ListViewModelProtocol: class {
    func fetchList()
}
class ListViewModel: ListViewModelProtocol {
    func fetchList() {
        print("fetching list")
    }
    
    
}
