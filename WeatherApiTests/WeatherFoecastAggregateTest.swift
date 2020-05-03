//
//  WeatherFoecastAggregateTest.swift
//  WeatherApiTests
//
//  Created by Johan Nilsson on 2020/05/03.
//  Copyright © 2020 Johan Nilsson. All rights reserved.
//

import Foundation
import XCTest

@testable import WeatherApi

class WeatherFoecastAggregateTest: XCTestCase {

    var aggregate = WeatherForecastAggregate()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // A Good place to replace the service
        // aggregate.weatherService = MyMockService()
        
        // Setup the ForecastList with one Forcast
        let testTemp = 10.1
        let testTextDate = "test date"
        let weather = Weather(main: "main", description: "Desc", icon: "icon")
        aggregate.theForecastList = [Forecast]()
        let forecast = Forecast(temp: testTemp, weather: weather, dateText: testTextDate)
        aggregate.theForecastList.append(forecast)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetForecastList() throws {
        XCTAssert(aggregate.getForecastList().count == 1)
    }

    func testClearFetchResult() throws {
        aggregate.clearFetchResult()
        XCTAssert(aggregate.getForecastList().count == 0)
        XCTAssert(aggregate.fetchLatestForecastLocation().name == Constants.unknown)
    }

    

    
}
