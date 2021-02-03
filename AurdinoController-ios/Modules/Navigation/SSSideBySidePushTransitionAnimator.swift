//
//  SSSideBySidePushTransitionAnimator.swift
//  AurdinoController-ios
//
//  Created by Saee Saadat on 1/21/21.
//

import UIKit

class FPSideBySidePushTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    enum pushTransitionDirection {
        case right
        case left
        case up
        case down
    }
    
    private let nav: SSNavigationController
    private var duration = 0.4
    private let direction: pushTransitionDirection
    
    init(direction: pushTransitionDirection) {
        self.direction = direction
        self.nav = SSNavigationController.shared
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toView = transitionContext.view(forKey: .to) ,
            let fromView = transitionContext.view(forKey: .from) else {
                transitionContext.completeTransition(false)
                return
        }
        
        //setup a bunch of frames to use ! super smart !
        let width = fromView.frame.size.width
        let height = fromView.frame.size.height
        let centerFrame = CGRect(x: 0, y: 0, width: width, height: height)
        let completeLeftFrame = CGRect(x: -width, y: 0, width: width, height: height)
        let completeRightFrame = CGRect(x: width, y: 0, width: width, height: height)
        let completeUpFrame = CGRect(x: 0, y: height, width: width, height: height)
        let completeDownFrame = CGRect(x: 0, y: -height, width: width, height: height)
        
        switch direction {
        case .left:
            transitionContext.containerView.addSubview(toView)
            toView.frame = completeRightFrame
        case .right:
            transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
            toView.frame = completeLeftFrame
        case .up:
            transitionContext.containerView.addSubview(toView)
            toView.frame = completeDownFrame
        case .down:
            transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
            toView.frame = completeUpFrame
        }
        
        toView.layoutIfNeeded()
        
        // MARK: Animation
        let animation : (() -> Void) = { [weak self] in
            guard let direction = self?.direction else {return}
            
            // move the frames :
            switch direction {
            case .right:
                fromView.frame = completeRightFrame
            case .left:
                fromView.frame = completeLeftFrame
            case .up:
                fromView.frame = completeUpFrame
            case .down:
                fromView.frame = completeDownFrame
            }
            toView.frame = centerFrame
            
        }
        
        let completion: ((Bool) -> Void) = { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        if transitionContext.isInteractive && direction == .right {
            regular(animation, duration: duration, completion: completion)
        } else {
            spring(animation, duration: duration, completion: completion)
        }
    
    }
    
    private func regular(_ animation: @escaping (() -> Void), duration: TimeInterval, completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: duration, animations: animation, completion: completion)
    }
    
    private func spring (_ animation: @escaping (() -> Void), duration: TimeInterval, completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.1, options: .allowUserInteraction, animations: animation, completion: completion)
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
}
