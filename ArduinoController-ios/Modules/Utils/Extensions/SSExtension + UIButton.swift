//
//  SSExtension + UIButton.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/17/21.
//

import UIKit

extension UIButton {
    
    func showLoading(show: Bool, failErrorText: String = "try.again") {
        if show {
            self.loading.start(
                .rotate(#imageLiteral(resourceName: "loading_indecator").withTintColor(SSColors.accent.color), at: 50),
                .text(failErrorText.localized, font: SSFont.errorFont(), color: .red),
                tag: SSViewTags.loadingIndicator.rawValue
            )
            self.setTitle(nil, for: .normal)
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.5)
            if let borderColor = self.layer.borderColor {
                self.layer.borderColor = UIColor(cgColor: borderColor).withAlphaComponent(0.5).cgColor
            }
            
        } else {
            self.loading.stop(SSViewTags.loadingIndicator.rawValue)
            self.setTitle(self.titleLabel?.text, for: .normal)
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(1)
            if let borderColor = self.layer.borderColor {
                self.layer.borderColor = UIColor(cgColor: borderColor).withAlphaComponent(1).cgColor
            }
        }
    }
    
}
