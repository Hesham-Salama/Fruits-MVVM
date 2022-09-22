//
//  FruitsViewModelTests.swift
//  Test2Tests
//
//  Created by Hesham on 22/09/2022.
//

import XCTest
@testable import Test2

class FruitsViewModelTests: XCTestCase {
    private var viewModel: FruitsViewModel!
    
    override func setUp() {
        viewModel = FruitsViewModel(fruitsDataRepo: FruitsDataRepositoryFakeImpl())
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testExistenceOfFruits() {
        viewModel.getFruits()
        XCTAssertEqual(viewModel.fruits.count, 4)
    }
}
