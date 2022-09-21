//
//  FruitsDataRepositoryLiveImpl.swift
//  Test2
//
//  Created by Hesham on 09/09/2022.
//

import Foundation

class FruitsDataRepositoryLiveImpl {
    // reversed to not be queried directly on Git hub
    private let fruitsURL: URL = URL(string: String("nosj.tiurf/niam/ipa/ttimhcsa/moc.tnetnocresubuhtig.war//:sptth".reversed()))!
    
    private var request: URLRequest {
        get {
            var urlRequest = URLRequest(url: fruitsURL)
            urlRequest.httpMethod = "GET"
            return urlRequest
        }
    }

}

extension FruitsDataRepositoryLiveImpl: FruitsDataRepository {
    func getFruits(completionHandler: @escaping (Result<[Fruit], Error>) -> ()) {
        NetworkService.execute(request: request) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                let fruits = try? decoder.decode(Fruits.self, from: data)
                completionHandler(.success(fruits?.fruits ?? []))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
