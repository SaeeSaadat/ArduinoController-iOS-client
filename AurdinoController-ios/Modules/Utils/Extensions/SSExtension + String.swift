//
//  SSExtension + String.swift
//  AurdinoController-ios
//
//  Created by Saee Saadat on 1/27/21.
//

import Foundation
extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: "Base", bundle: Bundle.main, value: "", comment: "")
    }
    
    var trim: String {
        return self.trimmingCharacters(
            in: CharacterSet.whitespacesAndNewlines
        )
    }
    
    mutating func localize() {
        self = self.localized
    }
    
}
