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
    func getURL(host:String?, path:String?) -> URL?
    func fetch(url:URL?, completion:@escaping(Result<[Model], NetworkErrors>)->Void)
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
