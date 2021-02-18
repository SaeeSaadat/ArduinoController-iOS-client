//
//  SSParseUserManager.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/18/21.
//

import Foundation
import Parse

class SSParseUserManager {
    
    public static func signup(username: String, password: String, email: String, onSuccess: (() -> Void)?, onFailed: ((Error) -> Void)?) {
        
        var user = PFUser()
        user.username = username
        user.password = password
        user.email = email
        user.signUpInBackground { succeeded, error in
            if let error = error {
                onFailed?(error)
            } else {
                onSuccess?()
            }
        }
    }
    
    public static func signin(username: String, password: String, onSuccess: ((PFUser) -> Void)?, onFailed: ((Error?) -> Void)?) {
        
        PFUser.logInWithUsername(inBackground: username, password: password) { user, error in
            if let user = user {
                onSuccess?(user)
            } else {
                onFailed?(error)
            }
        }
    }
    
    public static func logout() {
        PFUser.logOut()
    }
    
    public static func changePassword(newPassword: String, oldPassword: String,  onSuccess: (() -> Void)?, onFailed: ((Error?) -> Void)?) {
        guard let name = SSUserManager.name else { return }
        PFUser.logInWithUsername(inBackground: name, password: oldPassword) { user, error in
            if let user = user {
                user.password = newPassword
                user.saveInBackground() { succeed, error in
                    if succeed {
                        onSuccess?()
                    } else {
                        onFailed?(error)
                    }
                }
            } else {
                onFailed?(error)
            }
            
        }
    }
    
}
