//
//  Model.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 19/02/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation

struct Model: Codable {
    var author:String?
    var quote:String?
    
    enum CodingKeys:String, CodingKey {
        case author = "quoteAuthor"
        case quote = "quoteText"
    }
}
