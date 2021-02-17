//
//  SSMainListViewController.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 1/21/21.
//

import UIKit
import Loading

class SSMainListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = SSMainListViewModel()
    private var items: [SSArduinoModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
    }
    

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "SSAddArduinoTableViewCell", bundle: nil), forCellReuseIdentifier: "addArduinoCell")
        tableView.register(UINib(nibName: "SSArduinoTableViewCell", bundle: nil), forCellReuseIdentifier: "arduinoCell")
        
        tableView.layer.cornerRadius = 10.0
        
        loadModels()
    }
    
    private func loadModels() {
        tableView.loading.start(
            .rotate(#imageLiteral(resourceName: "loading_indecator").withTintColor(SSColors.accent.color), at: 50),
            .text("load.again".localized, font: SSFont.errorFont(), color: .red),
            tag: SSViewTags.loadingIndicator.rawValue
        )
        
        viewModel.getModels(page: 0, successfulCallBack: { models in
            self.tableView.loading.stop(SSViewTags.loadingIndicator.rawValue)
            self.items = models
            self.tableView.reloadData()
        }, failedCallBack: { error in
            SSNavigationController.shared.showBottomPopUpAlert(withTitle: error.message?.localized ?? "Error while loading", alertState: .failure)
            self.tableView.loading.fail(SSViewTags.loadingIndicator.rawValue) {
                self.loadModels()
            }
        })
    }

}

extension SSMainListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (items?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            SSNavigationController.shared.pushViewController(SSAddArduinoViewController(), animated: true)
        } else {
            let index = indexPath.row - 1
            guard let arduino = items?[index] else { return }
            print("dabadeedabadaa")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        
        var cell = UITableViewCell()
        cell.layer.cornerRadius = 10.0
        
        if index == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "addArduinoCell") ?? cell
            
        } else if let theCell = (tableView.dequeueReusableCell(withIdentifier: "arduinoCell") as? SSArduinoTableViewCell), let arduino = items?[index - 1] {
            
            theCell.setupCell(arduino: arduino, isLast: (index == items?.count) )
            cell = theCell
        }
        
        cell.selectionStyle = .default
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.row != 0 else { return nil }
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete".localized, handler: {_,_,handler in
            self.showDeleteDialog(index: indexPath.row - 1, handler: handler)
        })
        
        let renameAction = UIContextualAction(style: .normal, title: "Rename".localized, handler: { _,_,handler in
            self.showRenameDialog(index: indexPath.row - 1, handler: handler)
        })
        
        return UISwipeActionsConfiguration(actions: [deleteAction, renameAction])
    }
    
    private func showDeleteDialog(index: Int, handler: (@escaping (Bool) -> Void ) ) {
        guard let arduino = items?[index] else { return }
        let alert = UIAlertController(title: "delte.arduino".localized, message: "delete.arduino.message".localized + (arduino.name ?? " - "), preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "no".localized, style: .cancel, handler: { _ in
            handler(false)
        }))
        
        alert.addAction(UIAlertAction(title: "yes".localized, style: .default, handler: { _ in
            //TODO: DELETE API
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [IndexPath(row: index + 1, section: 0)], with: .left)
            self.items?.remove(at: index)
            self.tableView.endUpdates()
            
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func showRenameDialog(index: Int, handler: (@escaping (Bool) -> Void ) ) {
     
        guard let arduino = items?[index] else { return }
        let alert = UIAlertController(title: "rename.arduino".localized, message: "rename.arduino.message".localized + (arduino.name ?? " - "), preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "New Name"
        })
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .default, handler: { _ in
            handler(false)
        }))
        
        alert.addAction(UIAlertAction(title: "Ok".localized, style: .destructive, handler: { _ in
            
            guard let newName = alert.textFields?[0].text, !newName.isEmpty else {
                handler(false)
                return
            }
            
            //TODO: RENAME API
            self.tableView.beginUpdates()
            self.items?[index].name = newName
            self.tableView.reloadRows(at: [IndexPath(row: index + 1, section: 0)], with: .fade)
            self.tableView.endUpdates()
            handler(true)
            
        }))
        
        present(alert, animated: true, completion: nil)
        
    }
    
}
