//
//  ViewControllerPeekAnimationController.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 3/3/18.
//  Copyright © 2018 Chandlerdea. All rights reserved.
//

import UIKit

public final class ViewControllerPeekTransitionAnimationController: ViewControllerDefaultTransitionAnimationController {

    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ViewControllerPeekAnimator(isPresenting: true)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ViewControllerPeekAnimator(isPresenting: false)
    }
    
    public override func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        guard let presentable: ViewControllerPresentable & UIViewController = presented as? (UIViewController & ViewControllerPresentable) else {
            return .none
        }
        return ViewControllerPeekTransitionPresentationController(
            presentedViewController: presentable,
            presenting: presenting
        )
    }
}
