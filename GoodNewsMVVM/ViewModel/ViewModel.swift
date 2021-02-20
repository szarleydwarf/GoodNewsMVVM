//
//  ViewModel.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 19/02/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation

class ViewModel {
    private var service = NetworkService()
    
    var models: [Model]? {
        didSet {
            
        }
    }
    
//    init(services: Networking = NetworkService()) {
//        self.service = services
//    }
    
    func requestModel() {
        let params:[String:String] = [ Const.urlMethod:Const.urlParamMethod,
            Const.urlFormat:Const.urlParamFormat,
            Const.urlLang:Const.urlParamLang
        ]
        guard let url = self.service.getURL(host: Const.urlHost, path: Const.urlPath, params: params) else {return}
        print("VMURL>> \(url) \(Const.quotesAPI)")
        self.service.fetch(url: url) { (result) in
            switch result {
            case .success(let models):
                self.models = models
                
            case .failure(let e):
                print("ERROR \(e)")
            }
        }
    }
}
