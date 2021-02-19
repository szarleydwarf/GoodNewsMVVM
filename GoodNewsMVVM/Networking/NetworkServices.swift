//
//  NetworkServices.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 19/02/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation

protocol Networking {
    func getURL(scheme:String, host:String, path:String, query:[String]) -> URL
    func fetch(url:URL, completion:@escaping(Result<Model, Error>)->Void)
}
