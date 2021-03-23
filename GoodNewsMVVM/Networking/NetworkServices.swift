//
//  NetworkServices.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 19/02/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation
import Alamofire


enum NetworkErrors: Error {
    case badURL
    case noData
    case couldNotDecode
}

protocol NetworkingProtocol {
    func getURL(host:String?, path:String?, params:[String:String]?) -> URL?
    func fetch(url:URL?, completion:@escaping(Result<Model, NetworkErrors>)->Void)
    func fetchWithAlamo(url:URL, comletion:@escaping(Result<Image, NetworkErrors>)->Void)
}

class NetworkService: NetworkingProtocol {

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
        return components.url
    }
        
    func fetch(url: URL?, completion: @escaping (Result<Model, NetworkErrors>) -> Void) {
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
            guard let model = try? decoder.decode(Model.self, from: fetchedData) else {
                completion(.failure(.couldNotDecode))
                return
            }
            completion(.success(model))
        }.resume()
    }
    
    func fetchWithAlamo(url: URL, comletion: @escaping (Result<Image, NetworkErrors>) -> Void) {
        AF.request(Const.imageAPI).responseData { response in
            let decoder = JSONDecoder()
            guard let data = response.data else {
                comletion(.failure(.noData))
                return
            }
            
            guard let images = try? decoder.decode(Images.self, from: data) else  {
                comletion(.failure(.couldNotDecode))
                return
            }
            comletion(.success(images.hits[Maths().randomNumber(limit: images.hits.count)]))
        }
    }
}
