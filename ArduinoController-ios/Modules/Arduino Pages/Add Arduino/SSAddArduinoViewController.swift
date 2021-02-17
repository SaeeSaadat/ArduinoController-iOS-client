//
//  SSAddArduinoViewController.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/17/21.
//

import UIKit

class SSAddArduinoViewController: UIViewController {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var activationCodeTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        
        SSTitle = "addArduinoTableCell".localized
        setupButton()
        setupTextFields()
        
    }
    
    private func setupTextFields() {
        let fields = [nameTextField, modelTextField, activationCodeTextField]
        
        fields.forEach({
            guard let field = $0 else { return }
            field.makeItPretty()
        })
    }
    
    private func setupButton() {
        submitButton.layer.cornerRadius = 20.0
        submitButton.layer.borderWidth = 2.0
        submitButton.layer.borderColor = SSColors.accent.color.cgColor
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        submitButton.showLoading(show: true)
        
        //TODO
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.submitButton.showLoading(show: false)
        })
    }
}
