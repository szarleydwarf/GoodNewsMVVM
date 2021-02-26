//
//  ViewController.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 19/02/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var vm:ViewModel!
    @IBOutlet weak var theme: UIImageView! {
        didSet {
            theme.image = UIImage(named: "ducks")
        }
    }
    @IBOutlet weak var author: UILabel! {
        didSet {
            author.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var quote: UILabel! {
        didSet {
            quote.isUserInteractionEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm = ViewModel()
        self.vm.delegate = self
        self.vm.requestModel()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        self.author.addGestureRecognizer(tap)
    }
    
    @objc func didTap(_ sender: UITapGestureRecognizer) {
        print("AUTHOR LABEL TAPPED")
        self.vm.requestModel()
    }
    
    @IBAction func refreshQuote(_ sender: UIButton) {
        self.vm.requestModel()
    }
    
    @IBAction func labelTapped (_ sender: UITapGestureRecognizer) {
        print("Label tapped")
        self.vm.requestModel()
    }
}

extension ViewController: ViewModelProtocol {
    func refreshUI() {
        self.author.text = self.vm.model?.author
        self.quote.text = self.vm.model?.quote
    }
    
    func fadeAnimation(_ duration:CFTimeInterval) {
        let anim = CATransition()
        anim.timingFunction = CAMediaTimingFunction(name: .easeIn)
        anim.type = .fade
        anim.duration = duration
        //        anim.autoreverses = true
        self.quote.layer.add(anim, forKey: CATransitionType.fade.rawValue)
    }
    
    func scaleAnimation (_ duration: CFTimeInterval) {
        let scaleLayout = CASpringAnimation(keyPath: "transform.scale")
        scaleLayout.damping = 10
        scaleLayout.mass = 0.6
        scaleLayout.initialVelocity = 25
        scaleLayout.stiffness = 150.0
        
        scaleLayout.fromValue = 2.0
        scaleLayout.toValue = 1.0
        scaleLayout.duration = duration
        self.quote.layer.add(scaleLayout, forKey: nil)
        
    }
}
