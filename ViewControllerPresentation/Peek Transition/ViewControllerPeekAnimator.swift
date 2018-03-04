//
//  ViewControllerPeekAnimator.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 3/3/18.
//  Copyright © 2018 Chandlerdea. All rights reserved.
//

import Foundation

final class ViewControllerPeekAnimator: NSObject {
    
    // MARK: - Properties
    
    private static let backgroundYOffset: CGFloat = 20
    private static let viewsCornerRadius: CGFloat = 8
    private let isPresenting: Bool
    
    // MARK: - Init
    
    public init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
}
// MARK: - Private
private extension ViewControllerPeekAnimator {
    
    func topFrames(for containerView: UIView, viewController: UIViewController, viewFrame: CGRect) -> (initial: CGRect, final: CGRect) {
        var initialFrame: CGRect = viewFrame
        var finalFrame: CGRect = viewFrame
        
        if self.isPresenting {
            initialFrame.origin.y = viewFrame.height
            finalFrame.origin.y = UIScreen.main.bounds.height - viewController.preferredContentSize.height
        } else {
            initialFrame.origin.y = UIScreen.main.bounds.height - viewController.preferredContentSize.height
            finalFrame.origin.y = viewFrame.height
        }
        
        return (initialFrame, finalFrame)
    }
    
    func bottomFrames(for containerView: UIView, topViewController: UIViewController, viewFrame: CGRect) -> (initial: CGRect, final: CGRect) {
        var initialFrame: CGRect = viewFrame
        var finalFrame: CGRect = viewFrame
        
        let topViewYOrigin: CGFloat = UIScreen.main.bounds.height - topViewController.preferredContentSize.height
        if self.isPresenting {
            finalFrame.origin.x = type(of: self).backgroundYOffset
            finalFrame.origin.y = topViewYOrigin - type(of: self).backgroundYOffset
            finalFrame.size.width = viewFrame.width - (type(of: self).backgroundYOffset * 2)
        } else {
            initialFrame.origin.y = topViewYOrigin - type(of: self).backgroundYOffset
            initialFrame.origin.x = type(of: self).backgroundYOffset
            initialFrame.size.width = viewFrame.width - (type(of: self).backgroundYOffset * 2)
            finalFrame.origin.y = 0
            finalFrame.origin.x = 0
        }
        
        return (initialFrame, finalFrame)
    }
    
}
// MARK: - UIViewControllerAnimatedTransitioning
extension ViewControllerPeekAnimator: UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let topViewController: UIViewController
        let bottomViewController: UIViewController
        let containerView: UIView = transitionContext.containerView
        
        if self.isPresenting {
            topViewController = transitionContext.viewController(forKey: .to)!
            bottomViewController = transitionContext.viewController(forKey: .from)!
            transitionContext.containerView.addSubview(topViewController.view)
            
            topViewController.view.layer.masksToBounds = true
            topViewController.view.layer.cornerRadius = type(of: self).viewsCornerRadius
        } else {
            topViewController = transitionContext.viewController(forKey: .from)!
            bottomViewController = transitionContext.viewController(forKey: .to)!
        }
        
        let topInitialFrame: CGRect = transitionContext.finalFrame(for: topViewController)
        let bottomInitialFrame: CGRect = transitionContext.finalFrame(for: bottomViewController)
        
        let topFrames: (initial: CGRect, final: CGRect) = self.topFrames(
                                                              for: containerView,
                                                              viewController: topViewController,
                                                              viewFrame: topInitialFrame
                                                          )
        let bottomFrames: (initial: CGRect, final: CGRect) = self.bottomFrames(
                                                                 for: containerView,
                                                                 topViewController: topViewController,
                                                                 viewFrame: bottomInitialFrame
                                                             )
        
        topViewController.view.frame = topFrames.initial
        bottomViewController.view.frame = bottomFrames.initial
        
        let animationDuration: TimeInterval = self.transitionDuration(using: transitionContext)
        let animations: () -> () = {
            topViewController.view.frame = topFrames.final
            bottomViewController.view.frame = bottomFrames.final
            if self.isPresenting {
                bottomViewController.view.layer.masksToBounds = true
                bottomViewController.view.layer.cornerRadius = type(of: self).viewsCornerRadius
            } else {
                bottomViewController.view.layer.masksToBounds = false
                bottomViewController.view.layer.cornerRadius = 0
            }
        }
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            options: .curveEaseInOut,
            animations: animations
        ) { finished in
            transitionContext.completeTransition(finished)
        }
    }
}



