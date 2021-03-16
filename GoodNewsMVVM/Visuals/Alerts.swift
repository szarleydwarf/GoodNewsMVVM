//
//  Alerts.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 05/03/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import UIKit

enum AlertTypes {
    case info, warning, input
}

protocol AlertsProtocol {
    func displayAlert (in view:UIViewController, getsInput: Bool, completes:@escaping(_ clearUserData: Bool)->Void)
    func displayAlert(in view: UIViewController, completes:@escaping(_ name: String)->Void)
    
    func displayAlert(in view:UIViewController, of type: AlertTypes, with quote: Qoute?, completes:@escaping(_ result: String) -> Void)
}

class Alerts: AlertsProtocol {
    func displayAlert(in view: UIViewController, of type: AlertTypes, with quote: Qoute?, completes: @escaping (String) -> Void) {
        let alert = self.createAlert(of: type, with: quote)
        self.addActions(to: alert, of: type) { (answer) in
            DispatchQueue.main.async {
                completes(answer)
            }
        }
        view.present(alert, animated: true)
    }
    
    func createAlert(of type: AlertTypes, with quote: Qoute?) -> UIAlertController {
        let alert:UIAlertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        switch type {
        case .info:
            alert.title = Const.info + (quote?.author ?? Const.unknown)
            alert.message = quote?.text ?? Const.unknown
        case .input:
            alert.title = Const.giveMeYourName
            alert.message = nil
            alert.addTextField()
        case .warning:
            alert.title = Const.warning
            alert.message = Const.deletionWarning
        }
        
        return alert
    }
    
    func addActions (to alert:UIAlertController, of type:AlertTypes, comletion:@escaping(String) -> Void) {
        let cancel: UIAlertAction = UIAlertAction(title: Const.cancel, style: .default)
        
        var submit: UIAlertAction = UIAlertAction()
        switch type {
        case .info:
            submit = UIAlertAction(title: Const.ok, style: .default)
        case .input:
            submit = UIAlertAction(title: Const.submit, style: .default) { [unowned alert] _ in
                if let answer = alert.textFields![0].text {
                    comletion(answer)
                }
            }
        case .warning:
            submit = UIAlertAction(title: Const.submit, style: .default) { _ in
                comletion(Const.trueAnswer)
            }
        }
        alert.addAction(cancel)
        alert.addAction(submit)
    }
    
    // used to display warnings and info
    func displayAlert(in view: UIViewController, getsInput: Bool, completes: @escaping (Bool) -> Void) {
        let ac = UIAlertController(title: Const.warning, message: Const.deletionWarning, preferredStyle: .alert)
        let cancel = UIAlertAction(title: Const.cancel, style: .default)
        let proceed = UIAlertAction(title: Const.submit, style: .default) { _ in
            completes(true)
        }
        ac.addAction(cancel)
        ac.addAction(proceed)
        view.present(ac, animated: true)
    }
    
    // used to get an input from user, such as name
    func displayAlert(in view: UIViewController, completes:@escaping(_ name: String)->Void) {
        let ac = UIAlertController(title: Const.giveMeYourName, message: nil, preferredStyle: .alert)
        ac.addTextField()
        var answer:String?
        let cancel = UIAlertAction(title: Const.cancel, style: .default)
        
        let submitAction = UIAlertAction(title: Const.submit, style: .default) { [unowned ac] _ in
            answer = ac.textFields![0].text
            DispatchQueue.main.async {
                if let answer = answer {
                    completes(answer)
                }
            }
        }
        ac.addAction(cancel)
        ac.addAction(submitAction)
        view.present(ac, animated: true)
    }
    
    
}
