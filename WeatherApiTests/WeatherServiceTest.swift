//
//  WeatherServiceTest.swift
//  WeatherApiTests
//
//  Created by Johan Nilsson on 2020/04/28.
//  Copyright © 2020 Johan Nilsson. All rights reserved.
//

import Foundation
import XCTest

@testable import WeatherApi

class WeatherServiceTests: XCTestCase {
    
    var service = WeatherService()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        service = WeatherService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchLatestForcastLocation() {
        let location = service.fetchLatestForcastLocation()
        XCTAssertTrue(location.name == "Unknown")
        XCTAssertTrue(location.latitude == 0.0)
        XCTAssertTrue(location.longitude == 0.0)
    }
        
    func testFetchForcast() {
        let forcast = service.fetchForcast(city: nil, longitude: nil, latitude: nil)
        XCTAssertTrue(forcast != nil)
    }
}
