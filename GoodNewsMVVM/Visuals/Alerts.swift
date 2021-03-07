//
//  Alerts.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 05/03/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import UIKit

protocol AlertsProtocol {
    func displayAlert (in view:UIViewController, getsInput: Bool, completes:@escaping(_ name: String)->Void)
}
class Alerts: AlertsProtocol {
    func displayAlert(in view: UIViewController, getsInput: Bool = false, completes:@escaping(_ name: String)->Void) {
        print(getsInput)
        let ac = UIAlertController(title: "Enter your name", message: nil, preferredStyle: .alert)
        ac.addTextField()
        var answer:String?
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            answer = ac.textFields![0].text
            // do something interesting with "answer" here
            print("ANSWER >> \(answer)")
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
