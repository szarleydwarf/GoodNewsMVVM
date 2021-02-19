//
//  NetworkServices.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 19/02/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation

protocol Networking {
    func getURL(host:String?, path:String?) -> URL?
    func fetch(url:URL, completion:@escaping(Result<Model, Error>)->Void)
}

class NetworkService: Networking {
    func getURL(host: String?, path: String?) -> URL? {
        var components = URLComponents()
        components.scheme = Const().urlScheme
        components.host = host ?? ""
        components.path = path ?? ""
        if let url = components.url {
            return url
        }
        return nil
    }
        
    func fetch(url: URL, completion: @escaping (Result<Model, Error>) -> Void) {
        <#code#>
    }
    
    
}
