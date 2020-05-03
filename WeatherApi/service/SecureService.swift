//
//  SecureService.swift
//  WeatherApi
//
//  Created by Johan Nilsson on 2020/04/29.
//  Copyright © 2020 Johan Nilsson. All rights reserved.
//

import Foundation
import UIKit

class SecureService {
    //@_silgen_name("fileExists")  // vital for the function being visible from C
    //func fileExists(path: Any) -> Int
    //{
    //    print ("fileExists called in Swift \(path)")
    //    return 0
    //}
    //
    //@_silgen_name("writeToSystem")  // vital for the function being visible from C
    //func writeToSystem(path: String) -> Int
    //{
    //    print ("writeToSystem called in Swift with \(path)")
    //    return 0
    //}
    
    func isBroken() -> Bool {
        print("Swift calling C")
        if isJailbroken() == 0 {
            return false
        }
        return true
    }
    
    // Based on https://medium.com/@pinmadhon/how-to-check-your-app-is-installed-on-a-jailbroken-device-67fa0170cf56
    // Similar to answers at https://stackoverflow.com/questions/40860325/how-to-make-ios-application-tamper-evident
    // and https://stackoverflow.com/questions/413242/how-do-i-detect-that-an-ios-app-is-running-on-a-jailbroken-phone
    // and there are other posts
    // Note This method should be an inlined C function
    func isBrokenSwift() -> Bool {
        if TARGET_IPHONE_SIMULATOR != 1 {
            // Check 1 : existence of files that are common for jailbroken devices
            if FileManager.default.fileExists(atPath: "/Applications/Cydia.app") ||
                FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
                FileManager.default.fileExists(atPath: "/bin/bash") ||
                FileManager.default.fileExists(atPath: "/usr/sbin/sshd") ||
                FileManager.default.fileExists(atPath: "/etc/apt") ||
                FileManager.default.fileExists(atPath: "/private/var/lib/apt/") ||
                UIApplication.shared.canOpenURL(URL(string:"cydia://package/com.example.package")!) {
                return true
            }
            // Check 2 : Reading and writing in system directories (sandbox violation)
            let stringToWrite = "Jailbreak Test"
            do{
                try stringToWrite.write(toFile:"/private/JailbreakTest.txt", atomically:true, encoding:String.Encoding.utf8)
                // Device is jailbroken
                return true
            } catch {
                return false
            }
        } else {
            return false
        }
    }
}
