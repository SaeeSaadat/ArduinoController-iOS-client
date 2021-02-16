//
//  SSProfileViewController.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/15/21.
//

import UIKit
import Loading

class SSProfileViewController: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var editImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.SSTitle = "profile.title".localized
        setupView()
    }
    
    private func setupView() {
        
        //TODO: Avatar -> next versions
        
        nameTextField.text = SSUserManager.name
        
        let textFields = [nameTextField, oldPasswordTextField, passwordTextField, confirmPasswordTextField]
        
        textFields.forEach({ textField in
            textField?.borderStyle = .roundedRect
            textField?.layer.borderWidth = 1.0
            textField?.layer.borderColor = SSColors.accent2.color.cgColor
            textField?.layer.cornerRadius = 5.0
            textField?.attributedPlaceholder = NSAttributedString(string: (textField?.placeholder ?? "").localized, attributes: [NSAttributedString.Key.foregroundColor : SSColors.accent2.color.withAlphaComponent(0.3)])
        })
        
        saveButton.layer.cornerRadius = 10.0
        scrollView.alwaysBounceVertical = true
        
    }

    @IBAction func onSavedPressed(_ sender: Any) {
        saveButton.loading.start(.circle(line: SSColors.accent.color, line: 2.0), tag: SSViewTags.loadingIndicator.rawValue)
        saveButton.titleLabel?.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.saveButton.loading.stop(SSViewTags.loadingIndicator.rawValue)
            self.saveButton.titleLabel?.isHidden = false
        })
    }
    
}
