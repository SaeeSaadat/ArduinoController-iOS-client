//
//  SettingsViewController.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/12/21.
//

import UIKit

class SSSettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var items: [SettingsItem] = []
    private var profileItems: [SettingsItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupItems()
        setupTableView()
    }
    
    private func setupItems() {
        items = [
            SettingsItem(title: "theme.change".localized, icon: UIImage(named: "icon-theme")),
            SettingsItem(title: "language.change".localized, icon: UIImage(named: "icon-language")),
            SettingsItem(title: "logOut".localized, icon: UIImage(named: "icon-exit"))
        ]
        
        profileItems = [
            SettingsItem(title: "profileSettings".localized, icon: UIImage(named: "icon-profile"))
        ]
    }
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SSSettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "settingsItemCell")
        tableView.register(UINib(nibName: "SSSettingsProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "settingsProfileCell")
    }
    
    private func gotoProfile() {
        SSNavigationController.shared.pushNewViewController(page: .profile, animated: true)
    }
    
    private func showLogOutDialog() {
        let alert = UIAlertController(title: "logOut".localized, message: "logout.message".localized, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "no".localized, style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "yes".localized, style: .destructive, handler: { _ in
            (UIApplication.shared.delegate as? AppDelegate)?.logout()
        }))
        
        present(alert, animated: true, completion: nil)
    }

}


extension SSSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "settingsProfileCell") as? SSSettingsProfileTableViewCell
                cell?.setupCell(image: nil)
                cell?.selectionStyle = .none
                return cell ?? UITableViewCell()
                
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "settingsItemCell") as? SSSettingsTableViewCell
                let item = profileItems[indexPath.row - 1]
                cell?.setupCell(title: item.title, icon: item.icon)
                cell?.selectionStyle = .none
                return cell ?? UITableViewCell()
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingsItemCell") as? SSSettingsTableViewCell
            let item = items[indexPath.row]
            cell?.setupCell(title: item.title, icon: item.icon, isLast: indexPath.row == items.count - 1)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            gotoProfile()
        } else {
            switch indexPath.row {
            case 0:
                SSNavigationController.shared.showBottomPopUpAlert(withTitle: "Hopefully in the next version", alertState: .failure)
            case 1:
                SSNavigationController.shared.showBottomPopUpAlert(withTitle: "Hopefully in the next version", alertState: .failure)
            case 2:
                showLogOutDialog()
            default:
                return
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return profileItems.count + 1
        } else {
            return items.count
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    private struct SettingsItem {
        let title: String
        let icon: UIImage?
    }
}
