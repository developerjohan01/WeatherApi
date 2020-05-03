//
//  SecurityAggregate.swift
//  WeatherApi
//
//  Created by Johan Nilsson on 2020/05/03.
//  Copyright © 2020 Johan Nilsson. All rights reserved.
//

import Foundation

class SecurityAggregate {
    var securityService = SecureService() // this service can be replaced if needed

    func isBroken() -> Bool {
        return securityService.isBroken()
        // return securityService.isBrokenSwift()
    }
}
