//
//  ViewModel.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 19/02/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation

class ViewModel {
    private var service:Networking!
    var models = [Model]() {
        didSet {
            
        }
    }
    
    init(services: Networking = NetworkService()) {
        self.service = services
    }
    
    func requestModel() {
        
    }
}
