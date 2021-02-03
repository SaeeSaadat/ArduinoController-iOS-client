//
//  SSMainTabbarController.swift
//  AurdinoController-ios
//
//  Created by Saee Saadat on 1/27/21.
//

import UIKit

class SSMainTabBarController: UITabBarController {
    
    static var mainListController: UIViewController?
    static var settingsController: UIViewController?
    static var aboutUsController: UIViewController?
    
    override func viewDidLoad() {
        
        setupControllers()
        
    }
    
    private func setupControllers() {
        
        SSMainTabBarController.mainListController = SSNavigationController.shared.findViewController(page: .mainList)
        SSMainTabBarController.settingsController = SSNavigationController.shared.findViewController(page: .settings)
        SSMainTabBarController.aboutUsController = SSNavigationController.shared.findViewController(page: .aboutUs)
        
    }
}
