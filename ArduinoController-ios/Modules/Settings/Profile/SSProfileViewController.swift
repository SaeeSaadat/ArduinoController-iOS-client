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
        nameTextField.isUserInteractionEnabled = false
        
        let textFields = [nameTextField, oldPasswordTextField, passwordTextField, confirmPasswordTextField]
        
        textFields.forEach({ textField in
            textField?.makeItPretty()
            textField?.delegate = self
            textField?.attributedPlaceholder = NSAttributedString(string: (textField?.placeholder ?? "").localized, attributes: [NSAttributedString.Key.foregroundColor : SSColors.accent2.color.withAlphaComponent(0.3)])
        })
        
        saveButton.layer.cornerRadius = 10.0
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag
        
    }

    @IBAction func onSavedPressed(_ sender: Any) {
        
        self.view.endEditing(false)
        
        guard let oldPassword = oldPasswordTextField.text, !oldPassword.isEmpty else {
            invalidateTextField(oldPasswordTextField)
            showError(message: "empty.field")
            return
        }
        
        guard let password = passwordTextField.text, checkPassword(password) else {
            invalidateTextField(passwordTextField)
            showError(message: "password.rule")
            return
        }
        
        guard let passwordConf = confirmPasswordTextField.text, password == passwordConf else {
            invalidateTextField(confirmPasswordTextField)
            showError(message: "confirm.password.error")
            return
        }
        
        saveButton.showLoading(show: true)
        
        SSParseUserManager.changePassword(newPassword: password, oldPassword: oldPassword, onSuccess: {
            SSNavigationController.shared.showBottomPopUpAlert(withTitle: "success".localized, alertState: .success)
            [self.passwordTextField, self.confirmPasswordTextField, self.oldPasswordTextField].forEach({
                $0.text = nil
            })
            self.saveButton.showLoading(show: false)
        }, onFailed: { error in
            SSNavigationController.shared.showBottomPopUpAlert(withTitle: error?.localizedDescription ?? "unknown.error", alertState: .failure)
            self.saveButton.showLoading(show: false)
        })
        
        
    }
    
    private func checkPassword(_ password: String) -> Bool {
        let checker = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{5,}$")
        return checker.evaluate(with: password)
    }
    
    private func invalidateTextField(_ field: UITextField) {
        guard let line = field.viewWithTag(SSViewTags.textFieldSeparator.rawValue) else { return }
        line.backgroundColor = SSColors.errorRed.color.withAlphaComponent(0.7)
    }
    
    private func validateTextField(_ field: UITextField) {
        guard let line = field.viewWithTag(SSViewTags.textFieldSeparator.rawValue) else { return }
        line.backgroundColor = SSColors.accent2.color.withAlphaComponent(0.7)
    }
    
    private func showError(message: String) {
        SSNavigationController.shared.showBottomPopUpAlert(withTitle: message.localized, alertState: .failure)
    }
    
}

extension SSProfileViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        validateTextField(textField)
    }
}

