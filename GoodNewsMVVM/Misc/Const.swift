//
//  Const.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 19/02/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation

struct Const {
    static let quotesAPI = "https://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en"

    static let urlScheme:String = "https"
    static let urlHost:String = "api.forismatic.com"
    static let urlPath:String = "/api/1.0/"
    
    static let urlMethod:String = "method"
    static let urlParamMethod:String = "getQuote"
    static let urlFormat:String = "format"
    static let urlParamFormat:String = "json"
    static let urlLang:String = "lang"
    static let urlParamLang:String = "en"
    
    static let unknown = "UNKNOWN"
    

}
