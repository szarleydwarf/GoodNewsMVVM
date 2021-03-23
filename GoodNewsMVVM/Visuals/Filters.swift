//
//  Filters.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 02/03/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation
import UIKit

protocol FilterProtocol {
    func applyFilter (on image: UIImage?, filterNumber: Int, intensity: Float) -> UIImage?
}
extension FilterProtocol {
    func applyFilter (on image: UIImage?, filterNumber: Int = 0, intensity: Float = 0.66) -> UIImage? {
        return applyFilter(on: image, filterNumber: filterNumber, intensity: intensity)
    }
}

class Filters: FilterProtocol {
    private var context:CIContext = CIContext(options: nil)

    
    func applyFilter (on image: UIImage?, filterNumber: Int = 0, intensity: Float = 0.66) -> UIImage?{
        guard let image = image else{return nil}
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
