//
//  NetworkError.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/13/21.
//

import Foundation

struct NetworkError: Error {
    
    var serverCode: Int = 0
    var message: String?
    
}
