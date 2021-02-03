//
//  SSConstants.swift
//  AurdinoController-ios
//
//  Created by Saee Saadat on 1/21/21.
//

import UIKit

struct SSFont {
    
    static func titleFont(_ size: Float) -> UIFont {
        return UIFont(name: "DIN Condensed", size: CGFloat(size))!
    }
    
}

enum SSViewTags: Int {
    case bottomPopup = 1004
}
