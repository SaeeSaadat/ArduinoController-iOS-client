//
//  SSUserManager.swift
//  AurdinoController-ios
//
//  Created by Saee Saadat on 1/21/21.
//

import Foundation

class SSUserManager {
    
    static var sessionToken: String?
    static var name: String?
    static var mobileNumber: String?
    
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
    
}
