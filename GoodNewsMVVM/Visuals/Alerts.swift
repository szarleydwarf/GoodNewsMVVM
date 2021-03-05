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
        let ac = UIAlertController(title: "Enter your name", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0]
            // do something interesting with "answer" here
            print(answer)
        }

        ac.addAction(submitAction)

        view.present(ac, animated: true)
    }
    
    
}
