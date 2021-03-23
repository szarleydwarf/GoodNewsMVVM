//
//  Maths.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 23/03/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation

class Maths {
    func randomNumber(limit:Int) -> Int{
        return Int.random(in: 1 ..< limit)
    }
}
