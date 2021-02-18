//
//  SSParseManager.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/18/21.
//

import Foundation
import Parse

class SSParseManager {
    private static let parseConfig = ParseClientConfiguration {
        $0.applicationId = "lAkPCoNgkCfZmWjRLYpd2Vs0OnnQdyFrFiuKebLy"
        $0.server = "http://192.168.1.103/parse"
    }
    
    public static func initializeParse() {
        Parse.initialize(with: parseConfig)
    }
}
