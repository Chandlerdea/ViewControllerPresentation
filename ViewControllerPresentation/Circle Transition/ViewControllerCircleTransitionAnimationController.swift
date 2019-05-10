//
//  ViewControllerCircleTransitionAnimationController.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 5/9/19.
//  Copyright © 2019 Chandlerdea. All rights reserved.
//

import Foundation
import UIKit

public final class ViewControllerCircleTransitionAnimationController: ViewControllerDefaultTransitionAnimationController {
    
    // MARK: - Properties

    private let sourceFrame: CGRect

    // MARK: - Init
    
    public init(sourceFrame: CGRect) {
        self.sourceFrame = sourceFrame
        super.init()
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ViewControllerCircleTransitionAnimator(
            isPresenting: true,
            sourceFrame: self.sourceFrame
        )
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ViewControllerCircleTransitionAnimator(
            isPresenting: false,
            sourceFrame: self.sourceFrame
        )
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return .none
    }
    
}
