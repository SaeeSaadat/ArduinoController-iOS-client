//
//  SSBottomPopUpAlert.swift
//  AurdinoController-ios
//
//  Created by Saee Saadat on 1/21/21.
//

import UIKit

protocol PopupDelegate {
   func didDismiss()
    func didShow()
}

enum SSBottomPopUpAlertState {
    case success
    case failure
}

class SSBottomPopUpAlert: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var imageViewWidth: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    
    var timer: Timer?
    var delegate: PopupDelegate?
    
    init(for view: UIView) {
        
        super.init(frame: CGRect(x: 10, y: view.bounds.size.height, width: UIScreen.main.bounds.size.width - 20, height: 100))
        onCreate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        onCreate()
    }
    
    func onCreate() {
        Bundle.main.loadNibNamed("FPBottomPopUpAlert", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.layer.cornerRadius = 15
        
        closeButton.setImage(UIImage(named: "x-circle")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    func setAlert(title: String, alertState: SSBottomPopUpAlertState, image: UIImage? = nil) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = 20
        paragraphStyle.minimumLineHeight = 20
        paragraphStyle.alignment = .right
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.font, value: SSFont.titleFont(16.0), range: NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        
        if alertState == .success {
            contentView.backgroundColor = UIColor(named: "popup-background-success")
            label.textColor = UIColor(named: "normalTextColor")
            closeButton.tintColor = UIColor(named: "normalTextColor")
        } else {
            contentView.backgroundColor = UIColor(named: "popup-background-fail")
            label.textColor = UIColor(named: "normalTextColor")
            closeButton.tintColor = UIColor(named: "normalTextColor")
        }
        if let image = image {
            imageView.image = image
        } else {
            // update constraints
            imageViewWidth.constant = 0
            imageViewLeadingConstraint.constant = 0
        }
    }
    
    func show() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.frame.origin.y -= 75
            if let delegate = self.delegate {
                delegate.didShow()
            }
        }) { _ in
            self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.closeBottomPopUpAlert), userInfo: nil, repeats: false)
        }
    }
    
    @objc func closeBottomPopUpAlert() {
        if let timer = self.timer {
            timer.invalidate()
        }
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                self.frame.origin.y += 75
            }) { _ in
                self.removeFromSuperview()
                if let delegate = self.delegate {
                    delegate.didDismiss()
                }
            }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        closeBottomPopUpAlert()
    }
}
