//
//  ViewControllerOverlayTransitionAnimationController.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 12/7/17.
//  Copyright © 2017 Chandlerdea. All rights reserved.
//

import Foundation

public final class ViewControllerOverlayTransitionAnimationController: ViewControllerDefaultTransitionAnimationController {
    
    // MARK: - Properties
    
    private let overlay: ViewControllerOverlay
    
    // MARK: - Init
    
    public init(overlay: ViewControllerOverlay) {
        self.overlay = overlay
        super.init()
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ViewControllerOverlayAnimator(overlay: self.overlay, isPresenting: true)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ViewControllerOverlayAnimator(overlay: self.overlay, isPresenting: false)
    }
    
    public override func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        guard let presentable: ViewControllerPresentable & UIViewController = presented as? (UIViewController & ViewControllerPresentable) else {
            return .none
        }
        let result: ViewControllerOverlayTransitionPresentationController = ViewControllerOverlayTransitionPresentationController(
            overlay: self.overlay,
            presentedViewController: presentable,
            presenting: presenting
        )
        result.tapDelegate = self.tapDelegate
        return result
    }
}
