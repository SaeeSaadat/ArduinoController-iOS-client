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
    private var items: [ArduinoModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
    }
    

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "SSAddArduinoTableViewCell", bundle: nil), forCellReuseIdentifier: "addArduinoCell")
        tableView.register(UINib(nibName: "SSArduinoTableViewCell", bundle: nil), forCellReuseIdentifier: "arduinoCell")
        
        loadModels()
    }
    
    private func loadModels() {
        tableView.loading.start(
            .rotate(#imageLiteral(resourceName: "loading_indecator"), at: 50),
            .text("load_again".localized, font: SSFont.errorFont(), color: .red),
            tag: SSViewTags.loadingIndicator.rawValue
        )
        
        viewModel.getModels(page: 0, successfulCallBack: { models in
            self.tableView.loading.stop()
            self.items = models
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        
        var cell = UITableViewCell()
        
        if index == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "addArduinoCell") ?? cell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "arduinoCell") ?? cell
        }
        
        return cell
        
    }
    
    
}
