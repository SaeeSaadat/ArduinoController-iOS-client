//
//  SSArduinoModel.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/13/21.
//

import Foundation
import Parse

struct SSArduinoModel {
    
    var name: String?
    var description: String?
    var model: String?
    var serialNumber: String?
    var uniqueId: String?
    var functions: [SSArduinoFunction]?
    
    init(name: String?, description: String? = nil, model: String? = nil, serialNumber: String?, uniqueId: String? = nil, functions: [SSArduinoFunction]? = nil) {
        self.name = name
        self.description = description
        self.model = model
        self.serialNumber = serialNumber
        self.functions = functions
    }
    
    init(obj: PFObject, functions: [SSArduinoFunction]? = nil) {
        self.name = obj["name"] as? String
        self.description = obj["description"] as? String
        self.model = obj["model"] as? String
        self.uniqueId = obj.objectId
        self.functions = functions ?? self.functions
    }
}


class SSArduinoFunction: Decodable {
    
    var name: String
    var signalCode: String
    
    init(name: String, signalCode: String) {
        self.name = name
        self.signalCode = signalCode
    }
    
}
