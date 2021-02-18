//
//  SSControlArduinoViewController.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/17/21.
//

import UIKit

class SSControlArduinoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    private var model: SSArduinoModel?
    var functions: [SSArduinoFunction] {
        return self.model?.functions ?? []
    }
    private var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadModel()
    }
    
    func setupModel(model: SSArduinoModel) {
        self.model = model
    }

    private func setupView() {
        
        self.SSTitle = self.model?.name
        setupTableView()
        
    }
    
    private func loadModel() {
        guard let model = self.model else { return }
        
        tableView.loading.start(
            .rotate(#imageLiteral(resourceName: "loading_indecator").withTintColor(SSColors.accent.color), at: 50),
            .text("load.again".localized, font: SSFont.errorFont(), color: .red),
            tag: SSViewTags.loadingIndicator.rawValue
        )
        isLoading = true
        
        SSParseArduinoManager.loadArduino(arduino: model, success: { [weak self] arduino in
            self?.model = arduino
            self?.isLoading = false
            self?.tableView.reloadData()
            self?.tableView.loading.stop(SSViewTags.loadingIndicator.rawValue)
        }, fail: { error in
            SSNavigationController.shared.showBottomPopUpAlert(withTitle: error?.localizedDescription ?? "unknown.error".localized, alertState: .failure)
            SSNavigationController.shared.popViewController(animated: true)
        })
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "SSArduinoFunctionTableViewCell", bundle: nil), forCellReuseIdentifier: "functionCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension SSControlArduinoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let count = functions.count
        self.emptyView.isHidden = (count != 0 || self.isLoading)
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "functionCell") as? SSArduinoFunctionTableViewCell,
              let arduino = model,
              indexPath.section < functions.count
              else {
            return UITableViewCell()
        }
        let index = indexPath.section
        cell.setupCell(model: functions[index], arduino: arduino, index: index)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.row != 0 else { return nil }
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete".localized, handler: {_,_,handler in
            handler(true)
        })
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
