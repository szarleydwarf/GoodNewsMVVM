//
//  Animations.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 02/03/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation
import UIKit

protocol AnimationProtocol {
    func fade(_ duration: CFTimeInterval,_ reverse:Bool) -> CATransition
    func scale(_ duration:CFTimeInterval) -> CASpringAnimation
}

extension AnimationProtocol {
    func fade(_ duration: CFTimeInterval = 0.75,_ reverse:Bool = false) -> CATransition {
        return fade(duration, reverse)
    }
    func scale(_ duration:CFTimeInterval = 0.75) -> CASpringAnimation {
        return scale(duration)
    }
}

class Animations: AnimationProtocol {
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
  
    
}
