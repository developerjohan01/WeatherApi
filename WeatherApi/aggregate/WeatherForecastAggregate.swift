//
//  WeatherAggregate.swift
//  WeatherApi
//
//  Created by Johan Nilsson on 2020/05/03.
//  Copyright © 2020 Johan Nilsson. All rights reserved.
//

import Foundation

/**
    Helps to keep the data storage out of the UI and also isolated the UI from making direct server calls
 */
class WeatherForecastAggregate {
    var theForecastList = [Forecast]() // init this to a non nil list
    let unknownLocation = Location(name: Constants.unknown, latitude: 0.0, longitude: 0.0)
    var theLatestForecastLocation = Location(name: Constants.unknown, latitude: 0.0, longitude: 0.0)
    
    var weatherService = WeatherService() // this service can be replaced if needed
    
    func fetchLatestForecastLocation() -> Location {
        if let location = weatherService.fetchLatestForcastLocation() {
            theLatestForecastLocation = location
        } else {
            theLatestForecastLocation = unknownLocation
        }
        return theLatestForecastLocation
    }
    
    func getForecastList() -> [Forecast]{
        return theForecastList
    }
    
    func fetchNewForecast(city: String?, longitude: Double?, latitude: Double?) {
        theForecastList = [Forecast]()
        theForecastList = weatherService.fetchForcast(city: city, longitude: longitude, latitude: latitude)
    }
    
    func clearFetchResult() {
        theForecastList = [Forecast]()
        theLatestForecastLocation = unknownLocation
    }
}
