////
////  SSNavigationCustomAnimator.swift
////  AurdinoController-ios
////
////  Created by Saee Saadat on 1/21/21.
////
//
//import UIKit
//
//class SSNavigationCustomAnimator: NSObject, UIViewControllerAnimatedTransitioning {
//    
//    var duration: TimeInterval
//    var isPresenting: Bool
//    var originFrame: CGRect
//    
//    init(duration: TimeInterval, isPresenting: Bool, originFrame: CGRect) {
//        self.duration = duration
//        self.isPresenting = isPresenting
//        self.originFrame = originFrame
//    }
//    
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let container = transitionContext.containerView
//        
//        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
//        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
//        
//        self.isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
//        
//        let x = self.isPresenting ? (fromView.frame.width) : (-fromView.frame.width)
//        let y = CGFloat(0)
//        
//        fromView.frame = CGRect(x: 0, y: y, width: fromView.frame.width, height: fromView.frame.height)
//        toView.frame =  CGRect(x: x, y: y, width: toView.frame.width, height: toView.frame.height)
//        
//        fromView.layoutIfNeeded()
//        toView.layoutIfNeeded()
//        
//        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//            
//            let x = self.isPresenting ? (-fromView.frame.width) : (-fromView.frame.width)
//            let y = CGFloat(0)
//            
//            fromView.frame = CGRect(x: x, y: y, width: fromView.frame.width, height: fromView.frame.height)
//            toView.frame =  CGRect(x: 0, y: y, width: toView.frame.width, height: toView.frame.height)
//            
//        }, completion: { _ in
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        })
//        
//    }
//    
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return duration
//    }
//    
//}
