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
    
    var fade:(CFTimeInterval, Bool) -> CATransition
    var scale:(CFTimeInterval) ->CASpringAnimation
    
    init(services: Networking = NetworkService(), animations: Animations = Animations()) {
        self.service = services
        self.context = CIContext(options: nil)
        self.animations = animations
        self.fade = self.animations.fade(_:_:)
        self.scale = self.animations.scale(_:)
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
    
    
    func applyFilter (on image: UIImage, filterNumber: Int = 0, intensity: Float = 0.66) -> UIImage{
        let beginImage = CIImage(image: image)
        var imageToReturn: UIImage = UIImage()
        var filter: CIFilter = CIFilter()
        
        switch filterNumber {
        case 0:
            guard let currentFilter = CIFilter(name: "CISepiaTone") else {return UIImage()}
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            currentFilter.setValue(0.75, forKey: kCIInputIntensityKey)
            filter = currentFilter
        case 1:
            guard let blurFilter = CIFilter(name: "CIGaussianBlur") else {return UIImage()}
            blurFilter.setValue(beginImage, forKey: kCIInputImageKey)
            filter = blurFilter
        case 2:
            guard let lightenFilter = CIFilter(name:"CIColorControls") else {return UIImage()}
            lightenFilter.setValue(beginImage, forKey:kCIInputImageKey)
            lightenFilter.setValue(1 - intensity, forKey:"inputBrightness")
            lightenFilter.setValue(0, forKey:"inputSaturation")
            filter = lightenFilter
        case 3:
             guard let compositeFilter = CIFilter(name:"CIHardLightBlendMode")  else {return UIImage()}
            compositeFilter.setValue(beginImage, forKey:kCIInputImageKey)
            compositeFilter.setValue(beginImage, forKey:kCIInputBackgroundImageKey)
            filter = compositeFilter
        case 4:
            guard let vignetteFilter = CIFilter(name:"CIVignette")  else {return UIImage()}
            vignetteFilter.setValue(beginImage, forKey:kCIInputImageKey)
            vignetteFilter.setValue(intensity * 2, forKey:"inputIntensity")
            vignetteFilter.setValue(intensity * 30, forKey:"inputRadius")
            filter = vignetteFilter
        default:
            guard let currentFilter = CIFilter(name: "CISepiaTone") else {return UIImage()}
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            currentFilter.setValue(0.75, forKey: kCIInputIntensityKey)
            filter = currentFilter
        }
        
        if let output = filter.outputImage {
            if let cgimg = context.createCGImage(output, from: output.extent) {
                imageToReturn = UIImage(cgImage: cgimg)
            } else {
                print("cgimg not created")
            }
        }
        return imageToReturn
    }
}
