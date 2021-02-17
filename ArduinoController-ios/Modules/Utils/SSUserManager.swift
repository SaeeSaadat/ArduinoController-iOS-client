//
//  SSUserManager.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 1/21/21.
//

import Foundation

class SSUserManager {
    
    static var sessionToken: String?
    static var name: String?
    
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
