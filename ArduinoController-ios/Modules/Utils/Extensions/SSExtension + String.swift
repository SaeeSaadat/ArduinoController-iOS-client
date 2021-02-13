//
//  SSExtension + String.swift
//  ArduinoController-ios
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
    
    func truncateWord(_ maxLimit: Int) -> String {
        if self.count < maxLimit {
            return self
        } else {
            let indx = self.index(self.startIndex, offsetBy: maxLimit)
            let newText = String(self[..<indx])
            let lastSpaceIndex = NSString(string: newText).range(of: " ", options: String.CompareOptions.backwards).lowerBound
            let string = NSString(string: newText).substring(to: lastSpaceIndex)
            return String(string) + " ..."
        }
    }
}
