//
//  Toast.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 18/03/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import UIKit

class Toast {
    let animations = Animations()
    
    func displayToast(in view: UIView) {
        let toast = createSubCenterView(in: view, in: .systemBlue)
        let lab = createSubCenterView(in: toast, in: .systemYellow, with: "SAVED !!!")
        toast.addSubview(lab)
        self.animations.fadeOut(label: toast, duration: 1.75)
    }
    
    func createSubCenterView(in view: UIView, in color: UIColor, with text:String = "") -> UILabel{
        let box = UILabel()
        box.layer.cornerRadius = 10
        view.addSubview(box)
        box.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.height.equalTo(100)
            make.width.equalTo(view).inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        if !text.isEmpty{
            box.text = text
            box.textAlignment = .center
        }
        box.backgroundColor = color
        return box
    }
    
}
