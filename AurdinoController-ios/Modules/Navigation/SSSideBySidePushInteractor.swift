//
//  SSSideBySidePushInteractor.swift
//  AurdinoController-ios
//
//  Created by Saee Saadat on 1/21/21.
//

import UIKit

protocol NavigationInteractionProxy {
    var isPerforming: Bool { get }
}

class SSSideBySidePushInteractor: UIPercentDrivenInteractiveTransition, NavigationInteractionProxy {
    
    private weak var navigationController: SSNavigationController?
    let transitionCompletionThreshold: CGFloat = 0.1
    var completion: (() -> Void)?
    var viewController: UIViewController?
    
    var isPerforming: Bool = false
    
    var swipeBackGesture: UIScreenEdgePanGestureRecognizer?

    init?(attachTo viewController: UIViewController) {
        guard let nav = viewController.navigationController else { return nil }
        self.viewController = viewController
        self.navigationController = nav as? SSNavigationController
        super.init()
        setupBackGesture(view: viewController.view)
    }

    private func setupBackGesture(view: UIView) {
        self.swipeBackGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleBackGesture(_:)))
        if let swipeBackGesture = self.swipeBackGesture {
            swipeBackGesture.edges = .right
            view.addGestureRecognizer(swipeBackGesture)
        }
    }

    func removeBackGestureTarget() {
        self.swipeBackGesture?.removeTarget(self, action: #selector(handleBackGesture(_:)))
    }
    
    override func finish() {
        super.finish()
        completion?()
    }

    @objc internal func handleBackGesture(_ gesture: UIScreenEdgePanGestureRecognizer) {
        let viewTranslation = gesture.translation(in: gesture.view?.superview)
        let transitionProgress = ( (-viewTranslation.x) / (UIScreen.main.bounds.width * 2))

        switch gesture.state {
        case .began:
            isPerforming = true
            SSNavigationController.shared.pressedBack()
            
        case .changed:
            update(transitionProgress)
        case .cancelled:
            isPerforming = false
            cancelTransition(progress: transitionProgress)
        case .ended:
            if gesture.velocity(in: gesture.view).x < -300 {
                finish()
                return
            } else if gesture.velocity(in: gesture.view).x > 300 {
                cancelTransition(progress: transitionProgress)
                isPerforming = false
                return
            }
            isPerforming = false
            transitionProgress > transitionCompletionThreshold ? finish() : cancelTransition(progress: transitionProgress)
        default:
            return
        }
    }
    
    func cancelTransition(progress currentProgress: CGFloat) {
        var decreaseLevel: CGFloat = 0.001
        var progress = currentProgress
        _ = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: {[weak self] timer in
            progress -= decreaseLevel
            if decreaseLevel > 0.001 {
                decreaseLevel -= 0.000002
            }
            self?.update(progress)
            if progress < 0.01 {
                self?.cancel()
                timer.invalidate()
            }
        })
    }
    
    func swipeShouldPopToRootViewController() {
        self.removeBackGestureTarget()
        self.swipeBackGesture?.addTarget(self, action: #selector(self.popToRootViewController))
    }
    
    @objc func popToRootViewController(gesture: UIScreenEdgePanGestureRecognizer) {
        let viewTranslation = gesture.translation(in: gesture.view?.superview)
               let transitionProgress = ( (-viewTranslation.x) / (UIScreen.main.bounds.width * 2))

               switch gesture.state {
               case .began:
                // not using popToRootViewController because it would cause a bug on the title area !
                self.isPerforming = true
                navigationController?.viewControllers.removeAll(where: { vc in
                    vc != SSNavigationController.shared.viewControllers.last && vc != SSNavigationController.shared.viewControllers[0]
                })
                self.navigationController?.popViewController(animated: true)
                   
               case .changed:
                   self.update(transitionProgress)
               case .cancelled:
                   self.isPerforming = false
                   self.cancelTransition(progress: transitionProgress)
               case .ended:
                   if gesture.velocity(in: gesture.view).x < -300 {
                       self.finish()
                       return
                   } else if gesture.velocity(in: gesture.view).x > 300 {
                       self.cancelTransition(progress: transitionProgress)
                       self.isPerforming = false
                       return
                   }
                       
                   self.isPerforming = false
                   transitionProgress > self.transitionCompletionThreshold ? self.finish() : self.cancelTransition(progress: transitionProgress)
                
               default:
                   return
               }
    }
}
