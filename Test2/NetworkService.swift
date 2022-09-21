//
//  NetworkService.swift
//  Test2
//
//  Created by Hesham on 09/09/2022.
//

import Foundation

enum NetworkError: Error {
    case noConnection
    case genericError
    case invalidResponse
    case cancelled
}

class NetworkService {
    
    static func getDataTask(request: URLRequest, completionHandler: @escaping (Result<Data, Error>) -> ()) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                if let nserror = error as NSError?, nserror.code == NSURLErrorCancelled {
                    completionHandler(.failure(NetworkError.cancelled))
                } else {
                    completionHandler(.failure(NetworkError.genericError))
                }
                return
            }
            
            guard let response = response else {
                completionHandler(.failure(NetworkError.noConnection))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                completionHandler(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(NetworkError.invalidResponse))
                return
            }
            
            completionHandler(.success(data))
        }
    }
    
    static func execute(request: URLRequest, completionHandler: @escaping (Result<Data, Error>) -> ()) {
        let task = getDataTask(request: request, completionHandler: completionHandler)
        task.resume()
    }
}
