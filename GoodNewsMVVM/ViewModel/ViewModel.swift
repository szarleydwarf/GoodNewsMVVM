//
//  ViewModel.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 19/02/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation
import UIKit

protocol ViewModelProtocol: class {
    func refreshUI()
    func fadeAnimation()
    func scaleAnimation()
    func addFilter()
}

class ViewModel {
    private var service: Networking
    private var animations: Animation
    private var filters:Filter
    
    weak var delegate:ViewModelProtocol?
    
    var model: Model? {
        didSet {
            delegate?.fadeAnimation()
            delegate?.scaleAnimation()
            delegate?.addFilter()
            delegate?.refreshUI()
        }
    }
    
    var fade:(CFTimeInterval, Bool) -> CATransition
    var scale:(CFTimeInterval) ->CASpringAnimation
    var randomFilter: (UIImage,Int, Float) -> UIImage
    
    init(services: Networking = NetworkService(), animations: Animations = Animations(), filters:Filters = Filters()) {
        self.service = services
        self.animations = animations
        self.filters = filters
        
        self.fade = self.animations.fade(_:_:)
        self.scale = self.animations.scale(_:)
        self.randomFilter = self.filters.applyFilter(on:filterNumber:intensity:) 
    }
    
    func requestModel() {
        let params:[String:String] = [ Const.urlMethod:Const.urlParamMethod,
                                       Const.urlFormat:Const.urlParamFormat,
                                       Const.urlLang:Const.urlParamLang
        ]
        guard let url = self.service.getURL(host: Const.urlHost, path: Const.urlPath, params: params) else {return}
        
        self.service.fetch(url: url) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.model = model
                    if self?.model?.author == nil {
                        self?.model?.author = Const.unknown
                    }
                }
                
            case .failure(let e):
                print("ERROR \(e)")
            }
        }
    }
    

}
