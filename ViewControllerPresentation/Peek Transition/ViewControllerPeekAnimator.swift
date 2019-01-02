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
    
    private static let viewsCornerRadius: CGFloat = 8
    private let isPresenting: Bool
    internal let interactiveDismissalController: ViewControllerModalInteractiveDismissalController?
    
    // MARK: - Init
    
    public convenience init(isPresenting: Bool) {
        self.init(isPresenting: isPresenting, interactiveDismissalController: .none)
    }
    
    public init(isPresenting: Bool, interactiveDismissalController: ViewControllerModalInteractiveDismissalController?) {
        self.isPresenting = isPresenting
        self.interactiveDismissalController = interactiveDismissalController
        super.init()
    }
    
}
// MARK: - UIViewControllerAnimatedTransitioning
extension ViewControllerPeekAnimator: UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let presentedViewController: UIViewController
        let presentingViewController: UIViewController
        let containerView: UIView = transitionContext.containerView
        
        if self.isPresenting {
            presentedViewController = transitionContext.viewController(forKey: .to)!
            presentingViewController = transitionContext.viewController(forKey: .from)!
            containerView.addSubview(presentedViewController.view)
            
            presentingViewController.view.layer.masksToBounds = true
            presentedViewController.view.layer.masksToBounds = true
            presentedViewController.view.layer.cornerRadius = type(of: self).viewsCornerRadius
        } else {
            presentedViewController = transitionContext.viewController(forKey: .from)!
            presentingViewController = transitionContext.viewController(forKey: .to)!
        }
        
        var finalFrame: CGRect = transitionContext.finalFrame(for: presentedViewController)
        let bottomFrame: CGRect = CGRect(
            x: 0,
            y: UIScreen.main.bounds.height,
            width: finalFrame.size.width,
            height: finalFrame.size.height
        )
        
        if self.isPresenting {
            presentedViewController.view.frame = bottomFrame
        } else {
            finalFrame = bottomFrame
        }
        let animationDuration: TimeInterval = self.transitionDuration(using: transitionContext)
        let animations: () -> () = {
            
            presentedViewController.view.frame = finalFrame
            
            var isPhoneX: Bool = false
            if #available(iOS 11.0, *) {
                if let appDelegate: UIApplicationDelegate = UIApplication.shared.delegate,
                    let mainWindow: UIWindow? = appDelegate.window,
                    let insets: UIEdgeInsets = mainWindow?.safeAreaInsets,
                    insets.top > 0 {
                    isPhoneX = true
                }
            }
            let presentingScaleFactor: CGFloat = isPhoneX ? 0.9 : 0.92
            let scaleFactor: CGFloat = self.isPresenting || transitionContext.transitionWasCancelled ? presentingScaleFactor : 1.0
            presentingViewController.view.transform = CGAffineTransform(
                scaleX: scaleFactor,
                y: scaleFactor
            )
            if self.isPresenting || transitionContext.transitionWasCancelled {
                presentingViewController.view.layer.cornerRadius = type(of: self).viewsCornerRadius
            } else {
                presentingViewController.view.layer.cornerRadius = 0
            }
        }
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            options: .curveEaseInOut,
            animations: animations
        ) { finished in
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
    
}
// MARK: - UIViewControllerInteractiveTransitioning
extension ViewControllerPeekAnimator: UIViewControllerInteractiveTransitioning {
    
    var wantsInteractiveStart: Bool {
        return true
    }
    
    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let presentedViewController: UIViewController
        let presentingViewController: UIViewController
        let containerView: UIView = transitionContext.containerView
        
        if self.isPresenting {
            presentedViewController = transitionContext.viewController(forKey: .to)!
            presentingViewController = transitionContext.viewController(forKey: .from)!
            containerView.addSubview(presentedViewController.view)
            
            presentingViewController.view.layer.masksToBounds = true
            presentedViewController.view.layer.masksToBounds = true
            presentedViewController.view.layer.cornerRadius = type(of: self).viewsCornerRadius
        } else {
            presentedViewController = transitionContext.viewController(forKey: .from)!
            presentingViewController = transitionContext.viewController(forKey: .to)!
        }
        
        var finalFrame: CGRect = transitionContext.finalFrame(for: presentedViewController)
        let bottomFrame: CGRect = CGRect(
            x: 0,
            y: UIScreen.main.bounds.height,
            width: finalFrame.size.width,
            height: finalFrame.size.height
        )
        
        if self.isPresenting {
            presentedViewController.view.frame = bottomFrame
        } else {
            finalFrame = bottomFrame
        }
        
        let animationDuration: TimeInterval = self.transitionDuration(using: transitionContext)
        let animations: () -> () = {
            presentedViewController.view.frame = finalFrame
            
            var isPhoneX: Bool = false
            if #available(iOS 11.0, *) {
                if let appDelegate: UIApplicationDelegate = UIApplication.shared.delegate,
                    let mainWindow: UIWindow? = appDelegate.window,
                    let insets: UIEdgeInsets = mainWindow?.safeAreaInsets,
                    insets.top > 0 {
                    isPhoneX = true
                }
            }
            let presentingScaleFactor: CGFloat = isPhoneX ? 0.9 : 0.92
            let scaleFactor: CGFloat = self.isPresenting ? presentingScaleFactor : 1.0
            presentingViewController.view.transform = CGAffineTransform(
                scaleX: scaleFactor,
                y: scaleFactor
            )
            if self.isPresenting {
                presentingViewController.view.layer.cornerRadius = type(of: self).viewsCornerRadius
            } else {
                presentingViewController.view.layer.cornerRadius = 0
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



