//
//  SSMainTabbarController.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 1/27/21.
//

import UIKit

class SSMainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    static var mainListController: UIViewController?
    static var settingsController: UIViewController?
    static var aboutUsController: UIViewController?
    
    override func viewDidLoad() {
        
        setupControllers()
        setupNavigationBar()
        self.delegate = self
        
    }
    
    private func setupControllers() {
        
        SSMainTabBarController.mainListController = SSNavigationController.shared.findViewController(page: .mainList)
        SSMainTabBarController.settingsController = SSNavigationController.shared.findViewController(page: .settings)
        SSMainTabBarController.aboutUsController = SSNavigationController.shared.findViewController(page: .aboutUs)
        
        SSMainTabBarController.aboutUsController?.tabBarItem.image = UIImage(named: "tabicon-aboutus")
        SSMainTabBarController.mainListController?.tabBarItem.image = UIImage(named: "tabicon-main")
        SSMainTabBarController.settingsController?.tabBarItem.image = UIImage(named: "tabicon-settings")
        
        self.viewControllers = [SSMainTabBarController.aboutUsController!, SSMainTabBarController.mainListController!, SSMainTabBarController.settingsController!]
        
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = UIColor(named: "tabBarColor")
        
        SSMainTabBarController.aboutUsController?.tabBarItem.imageInsets = UIEdgeInsets(top: 25, left: 10, bottom: 0, right: 10)
        SSMainTabBarController.mainListController?.tabBarItem.imageInsets =  UIEdgeInsets(top: 25, left: 10, bottom: 0, right: 10)
        SSMainTabBarController.settingsController?.tabBarItem.imageInsets =  UIEdgeInsets(top: 25, left: 10, bottom: 0, right: 10)
        
        self.selectedIndex = 1
        
    }
    
    private func setupNavigationBar() {
        
        let nav = SSNavigationController.shared
        let navBar = nav.navigationBar
        let barLine = UIView()
        navBar.addSubview(barLine)
        barLine.translatesAutoresizingMaskIntoConstraints = false
        barLine.backgroundColor = SSColors.accent.color
        NSLayoutConstraint.activate([
            barLine.heightAnchor.constraint(equalToConstant: 2.0),
            barLine.bottomAnchor.constraint(equalTo: barLine.superview?.bottomAnchor ?? self.view.topAnchor),
            barLine.leadingAnchor.constraint(equalTo: barLine.superview?.leadingAnchor ?? self.view.leadingAnchor, constant: 20),
            barLine.trailingAnchor.constraint(equalTo: barLine.superview?.trailingAnchor ?? self.view.trailingAnchor, constant: -20)
        ])
        
        self.SSTitle = "mainListTitle".localized
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        switch viewController {
        case SSMainTabBarController.mainListController:
            self.SSTitle = "mainListTitle".localized
        case SSMainTabBarController.aboutUsController:
            self.SSTitle = "aboutUsTitle".localized
        case SSMainTabBarController.settingsController:
            self.SSTitle = "settingsTitle".localized
        default:
            self.SSTitle = "AWKWARD!".localized
        }
        
        return true
        
    }
}
