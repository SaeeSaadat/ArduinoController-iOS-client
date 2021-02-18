//
//  SSMainThemeColors.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/13/21.
//

import UIKit

enum SSColors: String {
    
    case accent         =   "AccentColor"
    case accent2        =   "AccentColor2"
    case background     =   "BackgroundColor"
    case background2    =   "BackgroundColor2"
    case background3    =   "BackgroundColor3"
    case normalText     =   "NormalTextColor"
    case oppositText    =   "OppositeTextColor"
    case fadeText       =   "fadeTextColor"
    case errorRed       =   "errorRedColor"
    case redBackground  =   "popup-background-fail"
    
    var color: UIColor {
        return UIColor(named: self.rawValue) ?? UIColor.white
    }
}
