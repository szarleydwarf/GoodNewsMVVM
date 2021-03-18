//
//  Toast.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 18/03/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import UIKit

class Toast {
    
    func displayToast(in view: UIView) {
        createView(in: view)
        
    }
    
    func createView(in view: UIView) {
        let box = UIView()
        box.layer.cornerRadius = 10
        view.addSubview(box)
        box.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.height.equalTo(100)
            make.width.equalTo(view).inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
                //make.equalTo(view).inset(UIEdgeInsets(top: 50,left: 50,bottom: 50,right: 50))
        }
        box.backgroundColor = .red
    }
    
}
