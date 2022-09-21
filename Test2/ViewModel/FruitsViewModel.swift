//
//  FruitsViewModel.swift
//  Test2
//
//  Created by Hesham on 09/09/2022.
//

import Foundation
import Combine

class FruitsViewModel {
    
    private let fruitsDataRepo: FruitsDataRepository
    @Published private(set) var fruits = [Fruit]()
    
    
    init(fruitsDataRepo: FruitsDataRepository) {
        self.fruitsDataRepo = fruitsDataRepo
    }
    
    func getFruits() {
        fruitsDataRepo.getFruits { [weak self] result in
            switch result {
            case .success(let fruits):
                self?.fruits = fruits
            case .failure(_):
                self?.fruits = []
            }
        }
    }
}
