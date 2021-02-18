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
    @IBOutlet weak var serialNumberTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
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
        let fields = [nameTextField, modelTextField, serialNumberTextField, descriptionTextField]
        
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
        
        let fields = [nameTextField, modelTextField, serialNumberTextField, descriptionTextField]
        
        var flag = false
        fields.forEach({
            guard let text = $0?.text else {
                flag = true
                return
            }
            if text.isEmpty {
                flag = true
                return
            }
        })
        
        if flag {
            SSNavigationController.shared.showBottomPopUpAlert(withTitle: "WRONG", alertState: .failure)
            return
        }
        
        let model = SSArduinoModel(name: nameTextField.text, description: descriptionTextField.text, model: modelTextField.text, serialNumber: serialNumberTextField.text, functions: nil)
        let vc = SSAddArduinoFunctionViewController()
        vc.model = model
        SSNavigationController.shared.pushViewController(vc, animated: true)
        
        self.submitButton.showLoading(show: false)
    }
}
