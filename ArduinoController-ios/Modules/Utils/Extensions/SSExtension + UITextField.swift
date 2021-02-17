//
//  SSExtension + UITextField.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/17/21.
//

import UIKit

extension UITextField {
    
    func makeItPretty(hasSeparator: Bool = false) {
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder?.localized ?? "", attributes: [NSAttributedString.Key.foregroundColor: SSColors.accent2.color.withAlphaComponent(0.3)])
        
        
        let separator = UIView()
        self.addSubview(separator)
        
        separator.tag = SSViewTags.textFieldSeparator.rawValue
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = SSColors.accent2.color.withAlphaComponent(0.7)
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1.0),
            separator.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -5),
            separator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
    }
    
}
