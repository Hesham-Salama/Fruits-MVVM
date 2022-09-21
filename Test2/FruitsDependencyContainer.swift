//
//  FruitsDependencyContainer.swift
//  Test2
//
//  Created by Hesham on 09/09/2022.
//

import Foundation

class FruitsDependencyContainer {
    static func getFruitsViewModel() -> FruitsViewModel {
        return FruitsViewModel(fruitsDataRepo: FruitsDataRepositoryLiveImpl())
    }
}
