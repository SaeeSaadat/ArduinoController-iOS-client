//
//  SSUserManager.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 1/21/21.
//

import Foundation

class SSUserManager {
    
    public static var isLoggedIn: Bool {
        get {
            if let isLoggedIn = SSUserDefault.getValue(key: .isLoggedIn) as? Bool {
                return isLoggedIn
            }else {
                SSUserDefault.setValue(false, key: .isLoggedIn)
                return false
            }
        }
    }
    
    public static var name: String? {
        return SSUserDefault.getValue(key: .name) as? String
    }
    
    public static var sessionToken: String? {
        return SSUserDefault.getValue(key: .sessionToken) as? String
    }
    
    //MARK: - Functions
    
    public static func logoutUser() {
        SSUserDefault.setValue(false, key: .isLoggedIn)
        SSUserDefault.setValue(nil, key: .name)
        SSUserDefault.setValue(nil, key: .sessionToken)
    }
    
    public static func loginUser(username: String, sessionToken: String) {
        SSUserDefault.setValue(username, key: .name)
        SSUserDefault.setValue(sessionToken, key: .sessionToken)
        SSUserDefault.setValue(true, key: .isLoggedIn)
    }
}
