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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupModel(model: SSArduinoModel) {
        self.model = model
    }

    private func setupView() {
        
        self.SSTitle = self.model?.name
        setupTableView()
        
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
        self.emptyView.isHidden = (count != 0)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "functionCell") as? SSArduinoFunctionTableViewCell else {
            return UITableViewCell()
        }
        let index = indexPath.section
        cell.setupCell(model: functions[index], index: index)
        return cell
    }
    
    
    
    
    
}
