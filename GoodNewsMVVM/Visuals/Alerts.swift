//
//  Alerts.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 05/03/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import UIKit

protocol AlertsProtocol {
    func displayAlert (in view:UIViewController, getsInput: Bool)
}
class Alerts: AlertsProtocol {
    func displayAlert(in view: UIViewController, getsInput: Bool = false) {
        print(getsInput)
    }
    
    
}
