//
//  UtilsTest.swift
//  WeatherApiTests
//
//  Created by Johan Nilsson on 2020/05/03.
//  Copyright © 2020 Johan Nilsson. All rights reserved.
//

import XCTest

@testable import WeatherApi

class UtilsTest: XCTestCase {

    var doubleVale: Double?
    var doubleValeToo: Double?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        doubleVale = 1.1111
        doubleValeToo = 8.8888
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRoundToLow() throws {
        if doubleVale != nil {
            XCTAssert(doubleVale!.round(to: 1) == 1.1)
            XCTAssert(doubleVale!.round(to: 2) == 1.11)
            XCTAssert(doubleVale!.round(to: 3) == 1.111)
            XCTAssert(doubleVale!.round(to: 4) == 1.1111)
        }
    }

    func testRoundToHigh() throws {
        if doubleValeToo != nil {
            XCTAssert(doubleValeToo!.round(to: 0) == 9)
            XCTAssert(doubleValeToo!.round(to: 1) == 8.9)
            XCTAssert(doubleValeToo!.round(to: 2) == 8.89)
            XCTAssert(doubleValeToo!.round(to: 3) == 8.889)
            XCTAssert(doubleValeToo!.round(to: 4) == 8.8888)
        }
    }

}
