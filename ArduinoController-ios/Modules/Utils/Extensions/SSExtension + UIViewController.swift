//
//  SSExtension + UIViewController.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/12/21.
//

import UIKit

extension UIViewController {
    
    var SSTitle: String? {
        set {
            let titleLabel = UILabel()
            titleLabel.text = (newValue ?? "").truncateWord(30)
            titleLabel.font = SSFont.titleFont(30)
            titleLabel.textColor = SSColors.accent.color
            titleLabel.sizeToFit()
            self.navigationItem.titleView = titleLabel
        }
        get {
            return (self.navigationItem.titleView as? UILabel)?.text
        }
    }
    
}
