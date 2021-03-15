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
    
    func displayAlert<T> (in view:UIViewController, of type: AlertTypes, with quote: Qoute?, completes:@escaping(_ result: T) -> Void)
}

class Alerts: AlertsProtocol {
    func displayAlert<T>(in view: UIViewController, of type: AlertTypes, with quote: Qoute?, completes: @escaping (T) -> Void) {
        let alert = self.createAlert(of: type, with: quote)
        view.present(alert, animated: true)
    }
    
    func createAlert(of type: AlertTypes, with quote: Qoute?) -> UIAlertController {
        var alert:UIAlertController = UIAlertController()
        
        switch type {
        case .info:
            alert.title = Const.info + (quote?.author ?? Const.unknown)
            alert.message = quote?.text ?? Const.unknown
            
        case .input:
            alert.title = Const.giveMeYourName
            alert.message = nil
        case .warning:
            alert.title = Const.warning
            alert.message = Const.deletionWarning
        }
        
        return alert
    }
    
    func addActions <T: Decodable> (to alert:UIAlertController, of type:AlertTypes, comletion:@escaping(T.Type?) -> Void) {
        var cancel: UIAlertAction = UIAlertAction()
        var submit: UIAlertAction = UIAlertAction()
        switch type {
        case .info:
            submit = UIAlertAction(title: Const.ok, style: .default)
        case .input:
            cancel = UIAlertAction(title: Const.cancel, style: .default)
            submit = UIAlertAction(title: Const.giveMeYourName, style: .default) { [unowned alert] _ in
                DispatchQueue.main.async {
                    if let answer = alert.textFields![0].text {
                        comletion(answer.self)
                    }
                }
            }
        case .warning:
            cancel = UIAlertAction(title: Const.cancel, style: .default)
            
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
