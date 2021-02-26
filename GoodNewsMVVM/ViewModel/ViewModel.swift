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
}

class ViewModel {
    private var service: Networking
    weak var delegate:ViewModelProtocol?
    
    var model: Model? {
        didSet {
            delegate?.fadeAnimation()
            delegate?.scaleAnimation()
            delegate?.refreshUI()
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
    
    func fadeAnimation(_ duration: CFTimeInterval = 0.75,_ reverse:Bool = false) -> CATransition {
        let anim = CATransition()
        anim.timingFunction = CAMediaTimingFunction(name: .easeIn)
        anim.type = .fade
        anim.duration = duration
        anim.autoreverses = reverse
        return anim
    }
    
    func scaleAnimation(_ duration:CFTimeInterval = 0.75) -> CASpringAnimation {
        
        let scaleLayout = CASpringAnimation(keyPath: "transform.scale")
        scaleLayout.damping = 10
        scaleLayout.mass = 0.6
        scaleLayout.initialVelocity = 25
        scaleLayout.stiffness = 150.0
        
        scaleLayout.fromValue = 2.0
        scaleLayout.toValue = 1.0
        scaleLayout.duration = duration
        return scaleLayout
        
    }
}
