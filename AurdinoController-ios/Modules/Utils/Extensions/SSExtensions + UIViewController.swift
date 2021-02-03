//
//  SSExtensions + UIViewController.swift
//  AurdinoController-ios
//
//  Created by Saee Saadat on 1/27/21.
//

import UIKit

extension UIView {
    
    /// localizes all labels, buttons and textfield inside the view recursively
    func localizeAllTexts() {
        self.subviews.forEach() { subview in
            if subview.subviews.count != 0 {
                subview.localizeAllTexts()
                subview.localizeViewText()
            }
        }
    }
    
    func localizeViewText() {
        if let theView = self as? UILabel{
            theView.text?.localize()
        }
        if let theView = self as? UIButton {
            theView.setTitle((theView.titleLabel?.text ?? "").localized, for: .normal)
        }
        if let theView = self as? UITextField {
            theView.text?.localize()
        }
    }
    
}

protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}

extension UILabel: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            if key != nil {
                text = key?.localized
            }
        }
    }
}

extension UIButton: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            if key != nil {
                setTitle(key?.localized, for: .normal)
            }
        }
    }
}

extension UITextField: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            if key != nil {
                text = key?.localized
            }
        }
    }
    
    var unwrappedText: String {
        let str = self.text ?? ""
        return str.trim
    }
}
