//
//  SSExtension + UITableView.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/12/21.
//

import UIKit

extension UITableView {
    
    public var hasFade: Bool {
        get {
            return self.layer.mask != nil
        }
        set {
            
        }
    }
    
}
