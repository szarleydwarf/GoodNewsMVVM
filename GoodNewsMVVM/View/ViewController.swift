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
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var quote: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm = ViewModel()
        self.vm.delegate = self
        self.vm.requestModel()
    }


}

extension ViewController: ViewModelProtocol {
    func refreshUI() {
        self.author.text = self.vm.model?.author
        self.quote.text = self.vm.model?.quote
    }
    
    func animate(_ duration:CFTimeInterval) {
        let anim = CATransition()
        anim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        anim.type = .fade
        anim.duration = duration
        anim.autoreverses = true
        self.quote.layer.add(anim, forKey: CATransitionType.fade.rawValue)
    }
}
