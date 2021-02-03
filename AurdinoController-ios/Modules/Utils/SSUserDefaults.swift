//
//  SSUserDefaults.swift
//  AurdinoController-ios
//
//  Created by Saee Saadat on 1/21/21.
//

import Foundation

enum SSUserDefaultKeys: String {
    
    case isLoggedIn
    case sessionToken
    
}

class SSUserDefault: NSObject {
    
    static func setValue(_ object: Any?, key: SSUserDefaultKeys) {
        UserDefaults.standard.set(object, forKey: key.rawValue)
    }
    
    static func getValue(key: SSUserDefaultKeys) -> Any? {
        return UserDefaults.standard.object(forKey: key.rawValue)
    }

    static func deleteValue(key: SSUserDefaultKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    static func deleteAllValues() {

        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
    }
}
