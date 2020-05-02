//
//  Utils.swift
//  WeatherApi
//
//  Created by Johan Nilsson on 2020/05/02.
//  Copyright © 2020 Johan Nilsson. All rights reserved.
//

import Foundation


// Simplify rounding of teperature via extension
extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
