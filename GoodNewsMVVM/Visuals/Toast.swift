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
        let box = UIView()
        view.addSubview(box)
        box.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left).offset(50)
            make.centerY.equalTo(view)
            make.width.height.equalTo(100)
                //make.equalTo(view).inset(UIEdgeInsets(top: 50,left: 50,bottom: 50,right: 50))
        }
        box.backgroundColor = .red
    }
}
