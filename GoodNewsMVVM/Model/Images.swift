//
//  Images.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 22/03/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation

struct Images:Decodable {
    let hits: [Image]
}

struct Image:Decodable {
    let previewURL:URL
}
