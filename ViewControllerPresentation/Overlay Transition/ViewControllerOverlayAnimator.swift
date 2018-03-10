//
//  ViewControllerOverlayAnimator.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 12/7/17.
//  Copyright © 2017 Chandlerdea. All rights reserved.
//

import UIKit

// public for testing
public final class ViewControllerOverlayAnimator: NSObject {
    
    // MARK: - Properties
    
    private let overlay: ViewControllerOverlay
    private let isPresenting: Bool
    
    // MARK: - Init
    
    public init(overlay: ViewControllerOverlay, isPresenting: Bool) {
        self.overlay = overlay
        self.isPresenting = isPresenting
        super.init()
    }
    
    public func frames(for containerView: UIView, viewFrame: CGRect) -> (initial: CGRect, final: CGRect) {
        var initialFrame: CGRect = viewFrame
        var finalFrame: CGRect = viewFrame
        
        if self.isPresenting {
            switch (self.overlay.entry, self.overlay.position) {
            // top entry
            case (.top, .top(let padding)):
                initialFrame.origin.y = -initialFrame.height
                finalFrame.origin.y = padding
            case (.top, .center):
                initialFrame.origin.y = -initialFrame.height
                finalFrame.origin.y = (containerView.bounds.height * 0.5) - (initialFrame.height * 0.5)
            case (.top, .bottom(let padding)):
                initialFrame.origin.y = -initialFrame.height
                finalFrame.origin.y = containerView.bounds.height - initialFrame.height - padding
                
            // left entry
            case (.left, .left(let padding)):
                initialFrame.origin.x = -initialFrame.width
                finalFrame.origin.x = padding
            case (.left, .center):
                initialFrame.origin.x = -initialFrame.width
                finalFrame.origin.x = (containerView.bounds.width * 0.5) - (initialFrame.width * 0.5)
            case (.left, .right(let padding)):
                initialFrame.origin.x = -initialFrame.width
                finalFrame.origin.x = containerView.bounds.width - initialFrame.width - padding
                
            // bottom entry
            case (.bottom, .top(let padding)):
                initialFrame.origin.y = containerView.bounds.height
                finalFrame.origin.y = padding
            case (.bottom, .center):
                initialFrame.origin.y = containerView.bounds.height
                finalFrame.origin.y = (containerView.bounds.height * 0.5) - (initialFrame.height * 0.5)
            case (.bottom, .bottom(let padding)):
                initialFrame.origin.y = containerView.bounds.height
                finalFrame.origin.y = containerView.bounds.height - initialFrame.height - padding
                
            // right entry
            case (.right, .left(let padding)):
                initialFrame.origin.x = containerView.bounds.width
                finalFrame.origin.x = padding
            case (.right, .center):
                initialFrame.origin.x = containerView.bounds.width
                finalFrame.origin.x = (containerView.bounds.width * 0.5) - (initialFrame.width * 0.5)
            case (.right, .right(let padding)):
                initialFrame.origin.x = containerView.bounds.width
                finalFrame.origin.x = containerView.bounds.width - initialFrame.width - padding
                
            default:
                return (.zero, .zero)
            }
        } else {
            switch self.overlay.exit {
            case .top:
                finalFrame.origin.y = -initialFrame.height
            case .left:
                finalFrame.origin.x = -initialFrame.width
            case .bottom:
                finalFrame.origin.y = containerView.bounds.height
            case .right:
                finalFrame.origin.x = containerView.bounds.width
            }
        }

        return (initialFrame, finalFrame)
    }

}
// MARK: - UIViewControllerAnimatedTransitioning
extension ViewControllerOverlayAnimator: UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let viewController: UIViewController
        let containerView: UIView = transitionContext.containerView
        if self.isPresenting {
            viewController = transitionContext.viewController(forKey: .to)!
            containerView.addSubview(viewController.view)
        } else {
            viewController = transitionContext.viewController(forKey: .from)!
        }
        let finalFrame: CGRect = transitionContext.finalFrame(for: viewController)
        let frames: (initial: CGRect, final: CGRect) = self.frames(for: containerView, viewFrame: finalFrame)
        let animationDuration: TimeInterval = transitionDuration(using: transitionContext)
        viewController.view.frame = frames.initial
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut, animations: {
            viewController.view.frame = frames.final
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
}
