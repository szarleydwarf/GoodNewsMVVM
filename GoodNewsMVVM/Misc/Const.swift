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
    static let imageAPI = "https://pixabay.com/api/?key=18691967-c6bbf9bfa8dba2ffd4c907bb5&q=nature+horizontal&image_type=photo"

    static let urlScheme:String = "https"
    static let urlHost:String = "api.forismatic.com"
    static let urlPath:String = "/api/1.0/"

    static let urlMethod:String = "method"
    static let urlParamMethod:String = "getQuote"
    static let urlFormat:String = "format"
    static let urlParamFormat:String = "json"
    static let urlLang:String = "lang"
    static let urlParamLang:String = "en"

    static let urlHostImages:String = "pixabay.com"
    static let urlPathImages:String = "/api/"
    
    static let urlKeyPixabay:String = "key"
    static let urlParamKey:String = "18691967-c6bbf9bfa8dba2ffd4c907bb5"
    static let urlQueryPixabay:String = "q"
    static let urlQueryParamPixabay:String = "nature+horizontal"
    static let urlImageType:String = "image_type"
    static let urlImageTypeParam:String = "photo"
    


    static let unknown = "UNKNOWN"
    
    static let greetingLabelDefault = "Hello, tap on icon to add your name and be able to bookmark quotes."
    static let greetingLabel = "Hello, "
    static let imageName = "ducks"
    static let stranger = "stranger"
    
    static let name = "username"
    static let bookmarksCount = "bookmarksCount"
    
    static let persistentContainarName = "QuoteModel"
    static let errorSaving = "Could not save - "
    static let persistentContainer = "Coredata container error "
    
    static let giveMeYourName = "Enter your name to be able to bookmark qoute"
    static let deletionWarning = "This action will delete your records. Do you still want to proceed?"
    static let warning = "WARNING"
    static let cancel = "Cancel"
    static let submit = "Submit"
    
    static let userName = "(username)"
    static let bookmarked = "(number)"
    static let tableLabel = "Hello \(userName), you have \(bookmarked) bookmarked qoutes."
    
    static let info = "Qoute by -> "
    static let ok = "OK"
    static let trueAnswer = "true"
}
