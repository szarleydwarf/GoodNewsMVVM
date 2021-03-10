//
//  Alerts.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 05/03/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import UIKit

protocol AlertsProtocol {
    func displayAlert (in view:UIViewController, getsInput: Bool, completes:@escaping(_ clearUserData: Bool)->Void)
    func displayAlert(in view: UIViewController, completes:@escaping(_ name: String)->Void) 
}
class Alerts: AlertsProtocol {
    func displayAlert(in view: UIViewController, getsInput: Bool, completes: @escaping (Bool) -> Void) {
        print(getsInput)
        let ac = UIAlertController(title: "WARNING", message: "This action will delete your records. Do you still want to proceed?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        let proceed = UIAlertAction(title: "YES", style: .default) { _ in
            completes(true)
        }
        ac.addAction(cancel)
        ac.addAction(proceed)
        view.present(ac, animated: true)
    }
    
    func displayAlert(in view: UIViewController, completes:@escaping(_ name: String)->Void) {
        let ac = UIAlertController(title: "Enter your name", message: nil, preferredStyle: .alert)
        ac.addTextField()
        var answer:String?
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            answer = ac.textFields![0].text
            // do something interesting with "answer" here
            DispatchQueue.main.async {
                if let answer = answer {
                    completes(answer)
                }
            }
        }
        ac.addAction(submitAction)
        view.present(ac, animated: true)
    }
    
    
}
