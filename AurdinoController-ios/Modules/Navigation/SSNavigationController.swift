//
//  SSNavigationController.swift
//  AurdinoController-ios
//
//  Created by Saee Saadat on 1/21/21.
//

import UIKit

class SSNavigationController: UINavigationController, UINavigationControllerDelegate {

    public static var shared: SSNavigationController = SSNavigationController()
    
    var backBarButton: UIBarButtonItem?
    
    fileprivate var interactors: [NavigationInteractionProxy?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.customizeUI()
    }
    
    func customizeUI() {
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setRootViewController(page: SSPages) {
        self.setRootViewController(page: page, animated: true)
    }
    
    func setRootViewController(page: SSPages, animated: Bool) {
        
        self.setRootViewController(vc: findViewController(page: page), animated: animated)
    }
    
    func setRootViewController(vc: UIViewController) {
        self.setRootViewController(vc: vc, animated: true)
    }
    
    func setRootViewController(vc: UIViewController, animated: Bool) {
        UIView.performWithoutAnimation {
            vc.view.layoutIfNeeded()
        }
        
        self.setViewControllers([vc], animated: animated)
        self.addDefaultBackButton()
    }
    
    func addDefaultBackButton() {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        btn.addTarget(self, action: #selector(self.pressedBack), for: .touchUpInside)
        btn.imageView?.tintColor = UIColor(named: "AccentColor")
        btn.setImage(UIImage(systemName: "lessthan")!.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 42, bottom: 0, right: 0)
        
        self.backBarButton = UIBarButtonItem(customView: btn)
        
        self.addBackButton()
    }
    
    //very important!!! to go back call this function!
    @objc func pressedBack() {
        
        if let cancelableLastViewControllers = self.viewControllers.last as? FPPopCancelableViewController {
            if cancelableLastViewControllers.cancelViewControllerPop() {
                return
            }
        }
        
        self.popViewController(animated: true)
    }
    
    func pushNewViewController(page: SSPages) {
        
        self.pushNewViewController(page: page, animated: true)
    }
    
    func pushNewViewController(page: SSPages, animated: Bool) {
        self.pushViewController(findViewController(page: page), animated: animated)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIView())
        UIView.performWithoutAnimation {
            viewController.view.layoutIfNeeded()
        }
        super.pushViewController(viewController, animated: animated)
        self.addBackButton()
        initializeInteractor(for: viewController)
    }
    
    func findViewController(page: SSPages) -> UIViewController {
        let components = page.rawValue.components(separatedBy: "@")
        let identifier = components[0]
        let nibName = components[1]
        
        let story = UIStoryboard(name: nibName, bundle: self.nibBundle)
        
        return story.instantiateViewController(withIdentifier: identifier)
    }
    
    func addBackButton() {
        
        for i in 0..<self.viewControllers.count {
            
            if i > 0 {
                self.viewControllers[i].navigationItem.rightBarButtonItem = self.backBarButton
            }
        }
    }
    
    func removeBackButton() {
        self.viewControllers.last?.navigationItem.setRightBarButtonItems(nil, animated: true)
        
    }
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        switch operation {
        case .push:
            return FPSideBySidePushTransitionAnimator(direction: .right)
        default:
            return FPSideBySidePushTransitionAnimator(direction: .left)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController == navigationController.viewControllers.first {
            interactors.removeAll()
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        let interactor = interactors.last
        return interactor??.isPerforming == true ? (interactor as? UIViewControllerInteractiveTransitioning) : nil
    }
    
    func showBottomPopUpAlert(withTitle title: String, alertState: SSBottomPopUpAlertState, image: UIImage? = nil, delegate: PopupDelegate? = nil) {
        if alertState == .failure && self.view.viewWithTag(SSViewTags.bottomPopup.rawValue) != nil {
            return
        }
        let popUpView = SSBottomPopUpAlert(for: self.view)
        popUpView.setAlert(title: title, alertState: alertState, image: image)
        popUpView.delegate = delegate
        if alertState == .failure {
            popUpView.tag = SSViewTags.bottomPopup.rawValue
        }
        
        // Add optional image
        if let image = image {
            popUpView.imageView.image = image
        }
        
        self.view.addSubview(popUpView)
        popUpView.show()
    }
}

protocol FPPopCancelableViewController {
    
    func cancelViewControllerPop() -> Bool
    
}

// MARK: swipe back interactor
extension SSNavigationController {
    private func initializeInteractor (for vc: UIViewController) {
        let interactor = SSSideBySidePushInteractor(attachTo: vc)
        interactor?.completion = { [weak self] in
            if !(self?.interactors.isEmpty ?? true) {
                self?.interactors.removeLast()
            }
        }
        interactors.append(interactor)
    }
    
    private func removeLastInteractor(vc: UIViewController? = nil) {
        if let interactor = self.interactors.last as? SSSideBySidePushInteractor, interactor.viewController == (vc ?? self.viewControllers.last), !interactor.isPerforming {
            self.interactors.removeLast()
        }
    }
    
    public func removeSwipeBackInteractor() {
        self.removeLastInteractor()
    }
    
    public func getSwipeBackInteractor() -> SSSideBySidePushInteractor? {
        return self.interactors.last as? SSSideBySidePushInteractor
    }
    
    @discardableResult
    override func popViewController(animated: Bool) -> UIViewController? {
        let vc = super.popViewController(animated: true)
        self.removeLastInteractor(vc: vc)
        return vc
    }
    
    @discardableResult
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        return super.popToRootViewController(animated: animated)
    }
}
