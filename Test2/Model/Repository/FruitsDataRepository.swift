//
//  FruitsDataRepository.swift
//  Test2
//
//  Created by Hesham on 09/09/2022.
//

import Foundation

protocol FruitsDataRepository {
    func getFruits(completionHandler: @escaping (Result<[Fruit], Error>) -> ())
}
