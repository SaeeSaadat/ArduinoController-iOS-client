//
//  SSConstants.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 1/21/21.
//

import UIKit

struct SSFont {
    
    static func titleFont(_ size: Float) -> UIFont {
        return UIFont(name: "DINCondensed-Bold", size: CGFloat(size))!
    }
    static func errorFont(_ size: Float = 20) -> UIFont {
        return UIFont(name: "DIN Condensed", size: CGFloat(size))!
    }
    
}

enum SSViewTags: Int {
    case bottomPopup = 1004
    case loadingIndicator = 1005
    case secondLoadingIndicator = 1006
}
