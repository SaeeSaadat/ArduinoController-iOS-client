//
//  AppDelegate.swift
//  AurdinoController-ios
//
//  Created by Saee Saadat on 1/21/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var level = 0;
    var window: UIWindow?
    var lastActiveTime: Date?
    let userDefault = UserDefaults.standard

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func initials(window: UIWindow) {
        let navigation = SSNavigationController.shared
        self.window = window
        
        setLevel()
        setRoot(navigation: navigation)
        
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
    }
    
    private func setLevel() {
        if !SSUserManager.isLoggedIn {
            self.level = 0
        } else {
            self.level = 1
        }
    }
    
    private func setRoot(navigation: SSNavigationController) {
        switch self.level {
        case 0:
            navigation.setRootViewController(vc: navigation.findViewController(page: .mainList)) //TODO
        default:
            navigation.setRootViewController(vc: navigation.findViewController(page: .mainList))
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

