//
//  DomainRepository.swift
//  WeatherApi
//
//  Created by Johan Nilsson on 2020/05/03.
//  Copyright © 2020 Johan Nilsson. All rights reserved.
//

import Foundation

class DomainRepository {
    static let shared = DomainRepository() // singleton
    private init() {} // so we can't create this class externally
    
    let weatherAggregate = WeatherForecastAggregate()
    let securityAggregate = SecurityAggregate()
}
