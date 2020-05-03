//
//  LocationTest.swift
//  WeatherApiTests
//
//  Created by Johan Nilsson on 2020/05/03.
//  Copyright © 2020 Johan Nilsson. All rights reserved.
//

import XCTest
import Foundation

@testable import WeatherApi

class LocationTest: XCTestCase {
    
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }

    func testLocationCreation() throws {
        // This tests the assumtions made, e.g. default values.
        let location = Location(name: "City", latitude: 1.1, longitude: 2.2)

        XCTAssert(location.name == "City")
        XCTAssert(location.latitude == 1.1)
        XCTAssert(location.longitude == 2.2)        
    }

}
