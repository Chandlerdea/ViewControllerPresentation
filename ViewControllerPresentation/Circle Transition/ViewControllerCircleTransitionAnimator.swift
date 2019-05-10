//
//  ViewControllerCircleTransitionAnimator.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 5/9/19.
//  Copyright © 2019 Chandlerdea. All rights reserved.
//

import Foundation
import UIKit

final class ViewControllerCircleTransitionAnimator: ViewControllerAnimator {
    
    // MARK: - Properties
    
    private let sourceFrame: CGRect
    
    // MARK: - Init
    
    init(isPresenting: Bool, sourceFrame: CGRect) {
        self.sourceFrame = sourceFrame
        super.init(isPresenting: isPresenting)
    }
    
}
// MARK: - UIViewControllerAnimatedTransitioning
extension ViewControllerCircleTransitionAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let presentedViewController: UIViewController
        let presentedView: UIView
        let containerView: UIView = transitionContext.containerView
        
        if self.isPresenting {
            // Add the view of the presented view controller to the container view
            presentedViewController = transitionContext.viewController(forKey: .to)!
            presentedView = transitionContext.view(forKey: .to)!
            containerView.addSubview(presentedView)

            // Make the presented view controller's view have the same frame as the source view
            presentedView.frame = self.sourceFrame
            presentedView.clipsToBounds = true
            presentedView.layer.cornerRadius = self.sourceFrame.size.width * 0.5
        } else {
            presentedViewController = transitionContext.viewController(forKey: .from)!
            presentedView = transitionContext.view(forKey: .from)!
            
            // Make the view of the view controller being dismissed a circle and center it
            let height: CGFloat = presentedView.frame.height * 1.5
            presentedView.frame.size.height = height
            presentedView.frame.size.width = height
            presentedView.center = containerView.center
            presentedView.layer.cornerRadius = presentedView.frame.width * 0.5
        }
        
        let animationDuration: TimeInterval = transitionDuration(using: transitionContext)
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                if self.isPresenting {
                    // Make the view being presented a square
                    var finalFrame: CGRect = transitionContext.finalFrame(for: presentedViewController)
                    let height: CGFloat = finalFrame.height * 1.5
                    
                    // Move the center of the presented view to the center of the container
                    finalFrame.size.height = height
                    finalFrame.size.width = height
                    presentedView.frame = finalFrame
                    presentedView.center = containerView.center
                    presentedView.layer.cornerRadius = finalFrame.size.width * 0.5
                } else {
                    // Make the presented view the size of the source view
                    presentedView.frame = self.sourceFrame
                    // Move the center of the presented view to the center of the source view
                    presentedView.center = CGPoint(
                        x: self.sourceFrame.origin.x + (self.sourceFrame.width * 0.5),
                        y: self.sourceFrame.origin.y + (self.sourceFrame.height * 0.5)
                    )
                    presentedView.layer.cornerRadius = self.sourceFrame.width * 0.5
                }
            },
            completion:  { finished in
                presentedView.layer.cornerRadius = 0
                let finalFrame: CGRect = transitionContext.finalFrame(for: presentedViewController)
                presentedView.frame = finalFrame
                transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
            }
        )
    }
}
