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
    private var animations: AnimationProtocol!
    private var filters: FilterProtocol!
    private var tapCount:Int!
    @IBOutlet weak var theme: UIImageView! {
        didSet {
            theme.image = UIImage(named: "ducks")
            theme.isUserInteractionEnabled = true
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
        self.tapCount = 0
        self.animations = Animations()
        self.filters = Filters()
        self.vm = ViewModel()
        
        self.vm.delegate = self
        self.vm.requestModel()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        self.author.addGestureRecognizer(tap)
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        self.theme.addGestureRecognizer(imageTap)
    }
    
    // selector version of tap recognision
    @objc func didTap(_ sender: UITapGestureRecognizer) {
        self.vm.requestModel()
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let image = UIImage(named: "ducks") else {
            print("image not unwrapped")
            return
        }
        guard let tap = self.tapCount else {return}
        self.tapCount = self.tapCount < 4 ? self.tapCount + 1 : 0
        self.theme.image = self.filters.applyFilter(on: image, filterNumber: tap)
    }
    
    @IBAction func bookmrkQuote(_ sender: UIButton) {
    }
    
    @IBAction func refreshQuote(_ sender: UIButton) {
        self.vm.requestModel()
    }
    
    // storyboard(interface builder) version of tap recognision
    @IBAction func labelTapped (_ sender: UITapGestureRecognizer) {
        self.vm.requestModel()
    }
}

extension ViewController: ViewModelProtocol {
    func refreshUI() {
        self.fadeAnimation()
        self.scaleAnimation()
        
        self.author.text = self.vm.model?.author
        self.quote.text = self.vm.model?.quote
    }
}

extension ViewController: AnimationProtocol {
    func fadeAnimation() {
        self.quote.layer.add(self.animations.fade(1.5), forKey: CATransitionType.fade.rawValue)
    }
    
    func scaleAnimation () {
        self.quote.layer.add(self.animations.scale(1.25), forKey: nil)
    }
}
