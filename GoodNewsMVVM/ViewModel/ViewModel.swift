//
//  ViewModel.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 19/02/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation

protocol ViewModelProtocol: class {
    func refreshUI()
    func animate(_ duration:CFTimeInterval)
}

class ViewModel {
    private var service: Networking
    weak var delegate:ViewModelProtocol?
    
    var model: Model? {
        didSet {
            delegate?.refreshUI()
            delegate?.animate(0.75)
        }
    }
    
    init(services: Networking = NetworkService()) {
        self.service = services
    }
    
    func requestModel() {
        let params:[String:String] = [ Const.urlMethod:Const.urlParamMethod,
            Const.urlFormat:Const.urlParamFormat,
            Const.urlLang:Const.urlParamLang
        ]
        guard let url = self.service.getURL(host: Const.urlHost, path: Const.urlPath, params: params) else {return}
        
        self.service.fetch(url: url) { [weak self] result in
            switch result {
            case .success(let models):
                DispatchQueue.main.async {
                    self?.model = models

                }
                
            case .failure(let e):
                print("ERROR \(e)")
            }
        }
    }
}
