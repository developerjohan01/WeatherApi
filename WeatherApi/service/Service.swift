//
//  Service.swift
//  WeatherApi
//
//  Created by Johan Nilsson on 2020/04/27.
//  Copyright © 2020 Johan Nilsson. All rights reserved.
//

import Foundation
import SwiftyJSON

class Service {
    
    let unknownText = "Unknown"
    var locationName: String?
    var locationLatitude = 0.0
    var locationLongitude = 0.0
    var location: Location?
    
    let apiKey = "95e2e94ea24ac96e4906922370157046"
    var forecastList: [Forecast]?
    
    func fetchLatestForcastLocation() -> Location {
        return location ?? Location(name: locationName ?? unknownText, latitude: locationLatitude, longitude: locationLongitude)
    }
    
    func fetchForcast() -> [Forecast]? {
        let semaphore = DispatchSemaphore (value: 0)
        forecastList = [Forecast]()
        //      let urlString = "https://api.openweathermap.org/data/2.5/weather?q=Cape%20Town&units=metric&appid=" + apiKey
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lon=18.42&lat=-33.93&units=metric&appid=" + apiKey
        let url = URL(string: urlString)
        let request = URLRequest(url: url!) // OK to use ! there - I am setting the string
        //      let request = URLRequest(url: url!,timeoutInterval: Double.infinity) // OK to use ! there - I am setting the string
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let json = try JSON(data: data);
//                print(json)
                let nameResult = json["city"]["name"]
                if let name = nameResult.string {
                    self.locationName = name
                } else {
                    print(nameResult.error ?? "unknown error")
                }
                print("self.locationName")
                print(self.locationName as Any)
                
                let latResult = json["city"]["coord"]["lat"]
                if let lat = latResult.double {
                    self.locationLatitude = lat
                } else {
                    print(nameResult.error ?? "unknown error")
                }
                print("self.locationLatitude")
                print(self.locationLatitude as Any)

                let lonResult = json["city"]["coord"]["lon"]
                if let lon = lonResult.double {
                    self.locationLongitude = lon
                } else {
                    print(nameResult.error ?? "unknown error")
                }
                print("self.locationLongitude")
                print(self.locationLongitude as Any)
                
                self.location = Location(name: self.locationName ?? self.unknownText, latitude: self.locationLatitude ?? 0.0, longitude: self.locationLongitude ?? 0.0)
                print("self.location")
                print(self.location!)
                
                let forecastResult = json["list"]
                if let forecastList = forecastResult.array {
                    for forecastObject in forecastList {
                        let temp = forecastObject["main"]["temp"].double ?? 0.0
                        let weatherMain = forecastObject["weather"][0]["main"].string ?? self.unknownText
                        let weatherDescription = forecastObject["weather"][0]["description"].string ?? self.unknownText
                        let w = Weather(main: weatherMain, description: weatherDescription)
                        let dateText = forecastObject["dt_txt"].string ?? self.unknownText
                        let f = Forecast(temp: temp, weather: w, dateText: dateText)
                        self.forecastList?.append(f)
                    }
                } else {
                    print(forecastResult.error ?? "unknown error")
                }
                print("self.forecastList!")
                print(self.forecastList!)
                
                DispatchQueue.main.async {
                    print("inside DispatchQueue.main.async")
                }
                
            } catch {
                print("catch JSON Error")
            }
            
            print("before semaphore.signal()")
            semaphore.signal()
            print("after semaphore.signal()")
        }
        print("before task.resume()")
        task.resume()
        print("after task.resume()")
        print("before semaphore.wait()")
        semaphore.wait()
        print("after semaphore.wait()")
        return forecastList
    }
}
