//
//  ForecastTest.swift
//  WeatherApiTests
//
//  Created by Johan Nilsson on 2020/05/03.
//  Copyright © 2020 Johan Nilsson. All rights reserved.
//
import Foundation
import XCTest

@testable import WeatherApi

class ForecastTest: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }

    func testForecastCreation() throws {
        // This tests the assumtions made, e.g. default values
        
        let testDateString = "test date"
        let forecast = Forecast(weather: Weather(), dateText: testDateString)
        
        XCTAssert(forecast.dateText == testDateString)
        // XCTAssert(forecast1.weather != nil) // Comparing non-optional value of type 'Weather' to 'nil' always returns true
        XCTAssert(forecast.temp == 0.0)
        
        let weather = Weather()
        let forecastToo = Forecast(temp: 10.0, weather: weather, dateText: testDateString)
            
        XCTAssert(forecastToo.dateText == testDateString)
        XCTAssert(forecastToo.weather.description == weather.description)
        XCTAssert(forecastToo.weather as AnyObject !== weather as AnyObject) // NOT the same object since we are using structs
        XCTAssert(forecastToo.temp == 10.0)
    }

}
