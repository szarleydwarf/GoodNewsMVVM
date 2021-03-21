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
    @IBOutlet weak var goToListButton: UIButton!
    @IBOutlet weak var playMusicButton: UIButton!
    
    
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
        guard let name = self.vm.user?.name else {return}
        guard let text = self.greetingLabel.text else {return}
        if text.contains(name.capitalized) {
            self.alerts.displayAlert(in: self, of: .warning, with: nil) { (answer) in
                if answer == Const.trueAnswer {
                    self.vm.clearUserData()
                }
            }
        }
    }
    
    // buttons
    @IBAction func bookmarkQuote(_ sender: UIButton) {
        sender.layer.add(self.animations.scale(1.75), forKey: "button")
        
        if self.vm.checkIfUserExist() {
            if self.vm.saveQuote(author: self.author.text ?? Const.unknown, quote: quoteLabel.text ?? Const.unknown) {
                Toast().displayToast(in: self.view)
            }
            if var user = self.vm.user {
                let bookmarkCount = user.bookmarkCounts + 1
                user.bookmarkCounts = bookmarkCount
                self.vm.saveUser(user: user)
            }
        }
        else {
            self.alerts.displayAlert(in: self, of: .input, with: nil) { (name) in
                self.vm.saveUser(user: User(name: name, bookmarkCounts: 0))
            }
        }
    }
    
    @IBAction func goToNextView(_ sender: UIButton) {
        if self.vm.checkIfUserExist() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let lvc = storyboard.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController else { return }
            guard let user = self.vm.user else {return}
            lvc.vm = ListViewModel(user: user)
            present(lvc, animated: true, completion: nil)
        } else {
            self.alerts.displayAlert(in: self, of: .input, with: nil) { (name) in
                self.vm.saveUser(user: User(name: name, bookmarkCounts: 0))
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
    
    
    @IBAction func playMusic(_ sender: UIButton) {
        print("Music will start soon...")
    }
}

extension ViewController: ViewModelProtocol {
    func refreshUI() {
        self.fadeAnimation(on: self.quoteLabel)
        self.scaleAnimation()
        
        self.author.text = self.vm.model?.author
        self.quoteLabel.text = self.vm.model?.quote
    }
    
    func setLabel() {
        var text = Const.greetingLabel
        if let name = self.vm.user?.name {
            text += name.capitalized
        }
        self.greetingLabel.text = text
    }
    
    func setBookmarkButton () {
        if self.vm.checkIfUserExist() {
            self.bookmarkButton.alpha = 1
            self.goToListButton.alpha = 1
        } else{
            self.bookmarkButton.alpha = 0.5
            self.goToListButton.alpha = 0.5
        }
    }
}

extension ViewController: AnimationProtocol {
    func fadeAnimation(on label: UILabel) {
        label.layer.add(self.animations.fade(1.5), forKey: CATransitionType.fade.rawValue)
    }
    
    func scaleAnimation () {
        self.quoteLabel.layer.add(self.animations.scale(1.25), forKey: nil)
    }
}
