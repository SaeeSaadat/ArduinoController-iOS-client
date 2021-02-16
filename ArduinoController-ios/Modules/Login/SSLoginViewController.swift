//
//  SSLoginViewController.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/16/21.
//

import UIKit

class SSLoginViewController: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var confirmPasswordTextfield: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var switchDescLabel: UILabel!
    
    @IBOutlet weak var buttonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordTopConstraint: NSLayoutConstraint!
    
    private var mode: Int = 0 // 0 = signup , 1 = signin
    private let animationDuration: Double = 0.3
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SSNavigationController.shared.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SSNavigationController.shared.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

    }
    
    private func setupView() {
        setupTextFields()
        setupButton()
        scrollView.alwaysBounceVertical = true
    }
    
    private func setupTextFields() {
       
        let fields = [usernameTextfield, emailTextField, passwordTextfield, confirmPasswordTextfield]
        
        fields.forEach({
            if let field = $0 {
                field.attributedPlaceholder = NSAttributedString(string: field.placeholder?.localized ?? "", attributes: [NSAttributedString.Key.foregroundColor: SSColors.accent2.color.withAlphaComponent(0.3)])
                let separator = UIView()
                field.addSubview(separator)
                customizeSeparator(separator)
            }
        })
    }
    
    private func setupButton() {
        submitButton.layer.cornerRadius = 20.0
        submitButton.layer.borderWidth = 2.0
        submitButton.layer.borderColor = SSColors.accent.color.cgColor
    }

    @IBAction func switchMode(_ sender: UIButton) {
        if mode == 0 {
            sender.setTitle("sign.up".localized, for: .normal)
            switchToSignin()
        } else {
            sender.setTitle("sign.in".localized, for: .normal)
            switchToSignup()
        }
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
    }
}

extension SSLoginViewController { // Transition for the Login
    
    private func switchToSignin() {
        
        passwordTopConstraint.constant = ConstraintConstants.signinPasswordUp.rawValue
        buttonTopConstraint.constant = ConstraintConstants.signinButtonUp.rawValue
        
        self.submitButton.setTitle("sign.in".localized, for: .normal)
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.emailTextField.alpha = 0
            self.confirmPasswordTextfield.alpha = 0
            self.termsLabel.alpha = 0
            self.view.layoutIfNeeded()
        }, completion: { finished in
            if finished {
                self.emailTextField.isHidden = true
                self.confirmPasswordTextfield.isHidden = true
                self.termsLabel.isHidden = true
            }
        })
        
        UIView.transition(with: switchDescLabel, duration: animationDuration, options: [.transitionCrossDissolve], animations: {
            self.switchDescLabel.text = "switch.desc.sign.in".localized
        }, completion: nil)
        
        mode = 1
    }
    
    private func switchToSignup() {
        passwordTopConstraint.constant = ConstraintConstants.signupPasswordUp.rawValue
        buttonTopConstraint.constant = ConstraintConstants.signupButtonUp.rawValue
        
        self.emailTextField.isHidden = false
        self.confirmPasswordTextfield.isHidden = false
        self.termsLabel.isHidden = false
        self.submitButton.setTitle("sign.up".localized, for: .normal)
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.emailTextField.alpha = 1.0
            self.confirmPasswordTextfield.alpha = 1.0
            self.termsLabel.alpha = 1.0
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.transition(with: switchDescLabel, duration: animationDuration, options: [.transitionCrossDissolve], animations: {
            self.switchDescLabel.text = "switch.desc.sign.in".localized
        }, completion: nil)
        
            
        
        mode = 0
    }
    
    private enum ConstraintConstants : CGFloat {
        case signupButtonUp = 120
        case signupPasswordUp = 90
        case signinButtonUp = 45
        case signinPasswordUp = 15
    }
    
}

extension SSLoginViewController {
    private func customizeSeparator(_ view: UIView) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = SSColors.accent2.color.withAlphaComponent(0.7)
        guard let supview = view.superview else { return }
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 1.0),
            view.bottomAnchor.constraint(equalTo: supview.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: supview.leadingAnchor, constant: -5),
            view.trailingAnchor.constraint(equalTo: supview.trailingAnchor, constant: -5)
        ])
    }
}
