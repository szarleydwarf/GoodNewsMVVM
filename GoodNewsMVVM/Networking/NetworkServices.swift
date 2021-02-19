//
//  NetworkServices.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 19/02/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation

enum NetworkErrors: Error {
    case badURL
    case noData
    case couldNotDecode
}

protocol Networking {
    func getURL(host:String?, path:String?, params:[String:String]?) -> URL?
    func fetch(url:URL?, completion:@escaping(Result<[Model], NetworkErrors>)->Void)
}

class NetworkService: Networking {

    func getURL(host: String?, path: String?, params:[String:String]?) -> URL? {
        var components = URLComponents()
        components.scheme = Const.urlScheme
        guard let hostUnwraped = host else {return nil}
        guard let pathUnwrapped = path else { return nil }
        if let paramsUnwraped = params {
            var queryItems:[URLQueryItem]=[]
            for (k, v) in paramsUnwraped {
                let qi = URLQueryItem(name: k, value: v)
                queryItems.append(qi)
            }
            components.queryItems = queryItems
        }
        components.host = hostUnwraped
        components.path = pathUnwrapped
        print("URL is >> \(components.url)")
        return components.url
    }
        
    func fetch(url: URL?, completion: @escaping (Result<[Model], NetworkErrors>) -> Void) {
        guard let url = url else {
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let fetchedData = data else {
                completion(.failure(.noData))
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let models = try? decoder.decode([Model].self, from: fetchedData) else {
                completion(.failure(.couldNotDecode))
                return
            }
            completion(.success(models))
        }
    }
    
    
}
