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
    
    public static var hasLock: Bool {
        get {
            if let hasLock = SSUserDefault.getValue(key: .hasApplock) as? Bool {
                return hasLock
            }else {
                SSUserDefault.setValue(false, key: .hasApplock)
                return false
            }
        }
        set {
            SSUserDefault.setValue(newValue, key: .hasApplock)
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
        SSUserDefault.setValue(false, key: .hasApplock)
        SSUserDefault.setValue(nil, key: .passcode)
    }
    
    public static func loginUser(username: String, sessionToken: String) {
        SSUserDefault.setValue(username, key: .name)
        SSUserDefault.setValue(sessionToken, key: .sessionToken)
        SSUserDefault.setValue(true, key: .isLoggedIn)
    }
    
    public static func checkPasscode (input: String) -> Bool {
        guard let code = SSUserDefault.getValue(key: .passcode) as? String else {
            return false
        }
        return input == code
    }
    
    public static func setPasscode(input: String) {
        SSUserDefault.setValue(input, key: .passcode)
    }
}
