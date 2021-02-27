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
    private let context: CIContext

    weak var delegate:ViewModelProtocol?
    
    var model: Model? {
        didSet {
            delegate?.fadeAnimation()
            delegate?.scaleAnimation()
            delegate?.addFilter()
            delegate?.refreshUI()
        }
    }
    
   init(services: Networking = NetworkService()) {
        self.service = services
        self.context = CIContext(options: nil)

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
    
    func fade(_ duration: CFTimeInterval = 0.75,_ reverse:Bool = false) -> CATransition {
        let anim = CATransition()
        anim.timingFunction = CAMediaTimingFunction(name: .easeIn)
        anim.type = .fade
        anim.duration = duration
        anim.autoreverses = reverse
        return anim
    }
    
    func scale(_ duration:CFTimeInterval = 0.75) -> CASpringAnimation {
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
    
    func applyFilter (on image: UIImage) -> UIImage{

        if let currentFilter = CIFilter(name: "CISepiaTone") {
            let beginImage = CIImage(image: image)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            currentFilter.setValue(0.5, forKey: kCIInputIntensityKey)

            if let output = currentFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    let processedImage = UIImage(cgImage: cgimg)
                    return processedImage
                }
            }
        }
        return UIImage()
    }
}
