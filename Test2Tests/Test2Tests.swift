//
//  Test2Tests.swift
//  Test2Tests
//
//  Created by Hesham on 09/09/2022.
//

import XCTest
@testable import Test2

class Test2Tests: XCTestCase {
    let fakeRepo = FruitsDataRepositoryFakeImpl()
    
    func testFruitsCount() {
        fakeRepo.getFruits { result in
            switch result {
            case .success(let fruits):
                XCTAssert(fruits.count == 4, "Fruits items count is not equal to 4")
            case .failure(let error):
                XCTFail("Unexpected failure " + error.localizedDescription)
            }
        }
    }
    
    func testFruitsContent() {
        fakeRepo.getFruits { result in
            switch result {
            case .success(let fruits):
                XCTAssertEqual(fruits[0].name, "Apple", "its name is not Apple")
                XCTAssertEqual(fruits[1].price, 12, "its price is not equal to 12")
                XCTAssertEqual(fruits[2].weight, 0.1, "its weight is not equal to 0.1")
                XCTAssertEqual(fruits[3].imageLink, "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Pineapple_and_cross_section.jpg/286px-Pineapple_and_cross_section.jpg")
            case .failure(let error):
                XCTFail("Unexpected failure " + error.localizedDescription)
            }
        }
    }
}
