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
    private var alerts: AlertsProtocol!
    private var tapCount:Int!
    
    @IBOutlet weak var bookmarkButton: UIButton!
    
    
    @IBOutlet weak var greetingLabel: UILabel! {
        didSet {
            greetingLabel.text = Const.greetingLabel
            greetingLabel.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var theme: UIImageView! {
        didSet {
            theme.image = UIImage(named: Const.imageName)
            theme.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var author: UILabel! {
        didSet {
            author.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var quoteLabel: UILabel! {
        didSet {
            quoteLabel.isUserInteractionEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tapCount = 0
        self.animations = Animations()
        self.filters = Filters()
        self.alerts = Alerts()
        self.vm = ViewModel()
        
        self.vm.delegate = self
        self.vm.requestModel()
        self.vm.fetchUser()
        
        self.implementTapping()
    }
        
    func implementTapping () {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        self.author.addGestureRecognizer(tap)
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        self.theme.addGestureRecognizer(imageTap)
        
        let greetingsLabelTap = UITapGestureRecognizer(target: self, action: #selector(greetingLabelTapped(_:)))
        self.greetingLabel.addGestureRecognizer(greetingsLabelTap)
    }

    // selector version of tap recognision
    @objc func didTap(_ sender: UITapGestureRecognizer) {
        self.vm.requestModel()
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let image = UIImage(named: Const.imageName) else {
            return
        }
        guard let tap = self.tapCount else {return}
        self.tapCount = self.tapCount < 4 ? self.tapCount + 1 : 0
        self.theme.image = self.filters.applyFilter(on: image, filterNumber: tap)
    }
    
    @objc func greetingLabelTapped(_ sender: UITapGestureRecognizer) {
        print("Greeting tapped")
    }
    
    @IBAction func bookmarkQuote(_ sender: UIButton) {
        sender.layer.add(self.animations.scale(1.75), forKey: "button")
        
        if self.vm.checkIfEntryExist() {
            // save in core data & in userdefaults, no of bookmarks
            let quote = Qoute()
            quote.id = UUID().uuidString
            quote.text = quoteLabel.text ?? "NO QOUTE"
            if self.vm.saveQuote(quote: quote) {
                print("SAVED!!")
            }
            // udef no letbookmarks
            if var user = self.vm.user {
                let bookmarkCount = user.bookmarkCounts + 1
                user.bookmarkCounts = bookmarkCount
                self.vm.saveUser(user: user)
            }
        }
        else {
            self.alerts.displayAlert(in: self, getsInput: true) {answer in
                self.vm.saveUser(user: User(name: answer, bookmarkCounts: 0))
            }
        }
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
        self.quoteLabel.text = self.vm.model?.quote
    }
    
    func setLabel() {
        var text = Const.greetingLabel
        if let name = self.vm.user?.name {
            text += name
        }
        self.greetingLabel.text = text
    }
    
    func setBookmarkButton () {
        self.bookmarkButton.alpha = 1
    }
}

extension ViewController: AnimationProtocol {
    func fadeAnimation() {
        self.quoteLabel.layer.add(self.animations.fade(1.5), forKey: CATransitionType.fade.rawValue)
    }
    
    func scaleAnimation () {
        self.quoteLabel.layer.add(self.animations.scale(1.25), forKey: nil)
    }
}
