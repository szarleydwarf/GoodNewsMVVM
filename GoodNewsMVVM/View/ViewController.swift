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
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm = ViewModel()
        self.vm.delegate = self
        self.vm.requestModel()
    }


}

extension ViewController: ViewModelProtocol {
    func refreshUI() {
        print("REFRESHING")
    }
}
