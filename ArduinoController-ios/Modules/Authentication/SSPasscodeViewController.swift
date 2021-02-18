//
//  SSPasscodeViewController.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/17/21.
//

import UIKit
import SmileLock

class SSPasscodeViewController: UIViewController {

    private var passwordStackView: UIStackView!
    private var passwordContainerView: PasswordContainerView!
    private var kPasswordDigit = 4
    
    var validationSuccessFunc: (() -> Void)?
    var validationFailedFunc: (() -> Void)?
    var passcodeCreatedFunc: (() -> Void)?
    
    var createPasscode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        
        createStackView()
        
        passwordContainerView = PasswordContainerView.create(in: passwordStackView, digit: kPasswordDigit)
        passwordContainerView.delegate = self
        passwordContainerView.deleteButton.setTitle("Delete", for: .normal)
        passwordContainerView.tintColor = SSColors.accent2.color
        passwordContainerView.highlightedColor = SSColors.accent.color
        passwordContainerView.isVibrancyEffect = true
        
        self.view.backgroundColor = SSColors.background2.color
        
        passwordContainerView.touchAuthenticationEnabled = !createPasscode
        
        addBottomButton()
        
    }
    
    private func createStackView() {
        passwordStackView = UIStackView()
        passwordStackView.alignment = .center
        passwordStackView.axis = .vertical
        passwordStackView.translatesAutoresizingMaskIntoConstraints = false
        passwordStackView.spacing = 50
        
        self.view.addSubview(passwordStackView)
        
        NSLayoutConstraint.activate([
        
            passwordStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            passwordStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        ])
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = createPasscode ? "create.passcode".localized : "enter.passcode".localized
        label.textColor = SSColors.accent.color
        label.font = SSFont.titleFont(35)
        passwordStackView.addArrangedSubview(label)
    }
    
    private func addBottomButton() {
        
        let logoutButton = UIButton()
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("LogOut".localized, for: .normal)
        logoutButton.titleLabel?.textColor = SSColors.accent.color
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        self.view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.widthAnchor.constraint(equalToConstant: 150),
            logoutButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            logoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
    }
    
    @objc private func logout() {
        (UIApplication.shared.delegate as? AppDelegate)?.logout()
    }

}

extension SSPasscodeViewController: PasswordInputCompleteProtocol {
    func passwordInputComplete(_ passwordContainerView: PasswordContainerView, input: String) {
        if !createPasscode {
            if validation(input) {
                validationSuccess()
            } else {
                validationFail()
            }
        } else {
            SSUserManager.setPasscode(input: input)
            passcodeCreatedFunc?()
        }
    }
    
    func touchAuthenticationComplete(_ passwordContainerView: PasswordContainerView, success: Bool, error: Error?) {
        if success {
            self.validationSuccess()
        } else {
            passwordContainerView.clearInput()
        }
    }
    
    
}

private extension SSPasscodeViewController {
    func validation(_ input: String) -> Bool {
        return SSUserManager.checkPasscode(input: input)
    }
    
    func validationSuccess() {
        self.validationSuccessFunc?()
        dismiss(animated: true, completion: nil)
    }
    
    func validationFail() {
        self.validationFailedFunc?()
        passwordContainerView.wrongPassword()
    }
}
