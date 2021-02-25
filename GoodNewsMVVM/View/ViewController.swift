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
        let anim = CATransition()
        anim.timingFunction = CAMediaTimingFunction(name: .easeIn)
        anim.type = .fade
        anim.duration = 1.0
        anim.autoreverses = true
        self.quote.layer.animation(forKey: "fade")
        self.quote.text = self.vm.model?.quote
    }
}
