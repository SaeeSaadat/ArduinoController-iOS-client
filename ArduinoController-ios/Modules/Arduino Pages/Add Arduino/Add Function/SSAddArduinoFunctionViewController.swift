//
//  SSAddArduinoFunctionViewController.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/18/21.
//

import UIKit

class SSAddArduinoFunctionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var model: SSArduinoModel?
    private var functions: [SSArduinoFunction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SSTitle = "Add Functions"
        setupTableView()
    }

    private func setupTableView() {
        
        tableView.register(UINib(nibName: "SSAddArduinoFunctionTableViewCell", bundle: nil), forCellReuseIdentifier: "functionCell")
        tableView.register(UINib(nibName: "SSSingleButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "singleButton")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func add() {
        
        let alert = UIAlertController(title: "add.arduino".localized, message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Name"
        })
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Signal"
        })
        
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Ok".localized, style: .default, handler: { _ in
            
            guard let name = alert.textFields?[0].text, !name.isEmpty else {
                return
            }
            guard let signal = alert.textFields?[1].text, !signal.isEmpty else {
                return
            }
            
            let function = SSArduinoFunction(name: name, signalCode: signal)
            
            self.tableView.beginUpdates()
            self.functions.append(function)
            self.tableView.insertSections([self.functions.count], with: .right)
            self.tableView.endUpdates()
            
        }))
        
        present(alert, animated: true, completion: nil)
        
    }

    private func done() {
        guard functions.count > 0 else {
            SSNavigationController.shared.showBottomPopUpAlert(withTitle: "Would be a useless robot tho!", alertState: .failure)
            return
        }
        guard var model = self.model else {
            SSNavigationController.shared.showBottomPopUpAlert(withTitle: "Model not found", alertState: .failure)
            return
        }
        model.functions = self.functions
        SSParseArduinoManager.registerArduino(model: model, success: {
            NotificationCenter.default.post(name: Notification.Name("refreshMainList"), object: nil)
            SSNavigationController.shared.showBottomPopUpAlert(withTitle: "Successfully Added Arduino", alertState: .success)
            SSNavigationController.shared.popToRootViewController(animated: true)
            
        }, fail: { error in
            SSNavigationController.shared.showBottomPopUpAlert(withTitle: error.localizedDescription, alertState: .failure)
        })
    }
}

extension SSAddArduinoFunctionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return functions.count + 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.section
        if index == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "singleButton") as? SSSingleButtonTableViewCell
            cell?.setupCell(title: "Add", callBack: self.add)
            return cell ?? UITableViewCell()
        } else if index == functions.count + 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "singleButton") as? SSSingleButtonTableViewCell
            cell?.setupCell(title: "Done", callBack: self.done)
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "functionCell") as? SSAddArduinoFunctionTableViewCell
            cell?.setupCell(model: functions[index - 1])
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (section == 0) ? 0 : ((section == (functions.count + 1) || section == 1) ? 50 : 25)
    }
    
    
}
