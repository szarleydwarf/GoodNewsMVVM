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
    
    var fadeAnimation:CATransition {
        didSet {
            let anim = CATransition()
            anim.timingFunction = CAMediaTimingFunction(name: .easeIn)
            anim.type = .fade
            anim.duration = 2.75
            //        anim.autoreverses = true
        }
    }
    
    var scaleAnimation: CASpringAnimation {
        didSet {
            let scaleLayout = CASpringAnimation(keyPath: "transform.scale")
            scaleLayout.damping = 10
            scaleLayout.mass = 0.6
            scaleLayout.initialVelocity = 25
            scaleLayout.stiffness = 150.0
            
            scaleLayout.fromValue = 2.0
            scaleLayout.toValue = 1.0
            scaleLayout.duration = 0.75
        }
    }
    
    init(services: Networking = NetworkService()) {
        self.service = services
        self.fadeAnimation = CATransition()
        self.scaleAnimation = CASpringAnimation(keyPath: "transform.scale")
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
