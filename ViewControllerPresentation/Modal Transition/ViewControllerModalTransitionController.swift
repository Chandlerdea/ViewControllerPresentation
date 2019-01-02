//
//  ViewControllerModalTransitionController.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 3/6/18.
//  Copyright © 2018 Chandlerdea. All rights reserved.
//

import Foundation

public final class ViewControllerModalTransitionController: ViewControllerDefaultTransitionAnimationController {
    
    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ViewControllerModalAnimator(isPresenting: true)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let interactiveDismissal: ViewControllerModalInteractiveDismissable = dismissed as? ViewControllerModalInteractiveDismissable {
            return ViewControllerModalAnimator(
                isPresenting: false,
                interactiveDismissalController: interactiveDismissal.interactiveTransitioning
            )
        } else {
            return ViewControllerModalAnimator(isPresenting: false)
        }
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let peekAnimator: ViewControllerModalAnimator = animator as? ViewControllerModalAnimator,
            let interactiveDismissale: ViewControllerModalInteractiveDismissalController = peekAnimator.interactiveDismissalController,
            interactiveDismissale.interactionInProgress {
            return interactiveDismissale
        } else {
            return .none
        }
    }
}
