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
    
    var theLocationName: String?
    let apiKey = "95e2e94ea24ac96e4906922370157046"
    var dataArray: [AnyObject]?
    
    func fetchData() {
        let semaphore = DispatchSemaphore (value: 0)
        
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
                print(json)
                let nameResult = json["name"]
                if let name = nameResult.string {
                    self.theLocationName = name
                } else {
                    print(nameResult.error ?? "unknown error")
                }
                if let temperature = json["main"]["temp"].double {
                    print("temparature: \(temperature)")
                } else {
                    print("JSON Error")
                }
                let bobResult = json["bob"]
                if let bob = bobResult.dictionary {
                    print(bob)
                } else {
                    print(bobResult.error ?? "unknown error")
                }
                
                DispatchQueue.main.async {
                    print("inside DispatchQueue.main.async")
                }
                
            } catch {
                print("JSON Error")
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
    }
}
