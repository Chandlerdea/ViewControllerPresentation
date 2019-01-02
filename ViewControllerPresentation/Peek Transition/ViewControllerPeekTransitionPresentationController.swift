//
//  ViewControllerPeekTransitionPresentationController.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 3/3/18.
//  Copyright © 2018 Chandlerdea. All rights reserved.
//

import UIKit

final class ViewControllerPeekTransitionPresentationController: ViewControllerDefaultTransitionPresentationController {

    override var frameOfPresentedViewInContainerView: CGRect {
        let yOrigin: CGFloat = UIScreen.main.bounds.height - self.presentedViewController.preferredContentSize.height
        return CGRect(
            x: 0,
            y: yOrigin,
            width: self.presentedViewController.preferredContentSize.width,
            height: self.presentedViewController.preferredContentSize.height
        )
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        guard let coordinator: UIViewControllerTransitionCoordinator = self.presentedViewController.transitionCoordinator, coordinator.isAnimated == false else {
            return
        }
        coordinator.animate(alongsideTransition: { (transitionContext: UIViewControllerTransitionCoordinatorContext) in
            let presentedViewController: UIViewController
            let presentingViewController: UIViewController
            let containerView: UIView = transitionContext.containerView
            
            presentedViewController = transitionContext.viewController(forKey: .to)!
            presentingViewController = transitionContext.viewController(forKey: .from)!
            containerView.addSubview(presentedViewController.view)
            
            presentingViewController.view.layer.masksToBounds = true
            presentedViewController.view.layer.masksToBounds = true
            presentedViewController.view.layer.cornerRadius = 8
            presentingViewController.view.layer.cornerRadius = 8
            
            let finalFrame: CGRect = self.frameOfPresentedViewInContainerView
            let bottomFrame: CGRect = CGRect(
                x: 0,
                y: UIScreen.main.bounds.height,
                width: finalFrame.size.width,
                height: finalFrame.size.height
            )
            
            presentedViewController.view.frame = bottomFrame
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
            presentingViewController.view.transform = CGAffineTransform(
                scaleX: presentingScaleFactor,
                y: presentingScaleFactor
            )
        })
    }
}
