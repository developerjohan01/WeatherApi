//
//  WeatherTest.swift
//  WeatherApiTests
//
//  Created by Johan Nilsson on 2020/05/03.
//  Copyright © 2020 Johan Nilsson. All rights reserved.
//
import Foundation
import XCTest

@testable import WeatherApi

class WeatherTest: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }

    func testWeatherCreation() throws {
        // This tests the assumtions made, e.g. default values.
        let weather = Weather()
            
        XCTAssert(weather.main == Constants.unknown)
        XCTAssert(weather.description == Constants.unknown)
        XCTAssert(weather.icon == "")

        let weatherToo = Weather(main: "main", description: "desc", icon: "icon")
            
        XCTAssert(weatherToo.main == "main")
        XCTAssert(weatherToo.description == "desc")
        XCTAssert(weatherToo.icon == "icon")
    }

}
