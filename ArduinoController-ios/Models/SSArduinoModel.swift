//
//  SSArduinoModel.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/13/21.
//

import Foundation

struct SSArduinoModel: Decodable {
    
    var name: String?
    var description: String?
    var model: String?
    var uniqueId: String?
    
    var functions: [SSArduinoFunction]?
}


class SSArduinoFunction: Decodable {
    
    var name: String
    var signalCode: String
    
    init(name: String, signalCode: String) {
        self.name = name
        self.signalCode = signalCode
    }
    
}
