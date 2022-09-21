//
//  FruitsDataRepositoryFakeImpl.swift
//  Test2Tests
//
//  Created by Hesham on 22/09/2022.
//

import Foundation
@testable import Test2

class FruitsDataRepositoryFakeImpl {
    private var mockContentData: Data? {
        return getData(name: "fruits")
    }

    private func getData(name: String, withExtension: String = "json") -> Data? {
        let fileUrl = Bundle.main.url(forResource: name, withExtension: withExtension)
        return try? Data(contentsOf: fileUrl!)
    }
}

extension FruitsDataRepositoryFakeImpl: FruitsDataRepository {
    func getFruits(completionHandler: @escaping (Result<[Fruit], Error>) -> ()) {
        guard let mockContentData = mockContentData else {
            completionHandler(.failure(NetworkError.genericError))
            return
        }

        guard let fruits = try? JSONDecoder().decode(Fruits.self, from: mockContentData) else {
            completionHandler(.failure(NetworkError.genericError))
            return
        }
        completionHandler(.success(fruits.fruits))
    }
}
