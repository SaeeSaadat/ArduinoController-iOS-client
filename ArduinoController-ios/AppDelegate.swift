//
//  AppDelegate.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 1/21/21.
//

import UIKit
import SmileLock

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var level = 0;
    var window: UIWindow?
    var lastActiveTime: Date?
    let userDefault = UserDefaults.standard

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        SSParseManager.initializeParse()
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
            navigation.setRootViewController(vc: navigation.findViewController(page: .login))
        case 1:
            presentLocker(create: !SSUserManager.hasLock)
        default:
            let vc = SSMainTabBarController()
            navigation.setRootViewController(vc: vc)
        }
    }
    
    func logout() {
        SSUserManager.logoutUser()
        SSParseUserManager.logout()
        self.level = 0
        SSNavigationController.shared.setRootViewController(page: .login, animated: true)
    }
    
    func signin(username: String) {
        SSUserManager.loginUser(username: username)
        self.level = 2
        presentLocker(create: true)
    }
    
    func presentLocker(create: Bool) {
        let vc = SSPasscodeViewController()
        vc.createPasscode = create
        vc.passcodeCreatedFunc = {
            self.level = 2
            SSUserManager.hasLock = true
            self.setRoot(navigation: SSNavigationController.shared)
        }
        
        vc.validationSuccessFunc = {
            self.level = 2
            self.setRoot(navigation: SSNavigationController.shared)
        }
        
        SSNavigationController.shared.setRootViewController(vc: vc, animated: true)
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

