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
        switch (self.overlay.entry, self.overlay.position) {
        // top entry
        case (.top, .top(let padding)):
            if self.isPresenting {
                initialFrame.origin.y = -initialFrame.height
                finalFrame.origin.y = padding
            } else {
                finalFrame.origin.y = -initialFrame.height
            }
        case (.top, .center):
            if self.isPresenting {
                initialFrame.origin.y = -initialFrame.height
                finalFrame.origin.y = (containerView.bounds.height * 0.5) - (initialFrame.height * 0.5)
            } else {
                finalFrame.origin.y = -initialFrame.height
            }
        case (.top, .bottom(let padding)):
            if self.isPresenting {
                initialFrame.origin.y = -initialFrame.height
                finalFrame.origin.y = containerView.bounds.height - initialFrame.height - padding
            } else {
                finalFrame.origin.y = -initialFrame.height
            }
            
        // left entry
        case (.left, .left(let padding)):
            if self.isPresenting {
                initialFrame.origin.x = -initialFrame.width
                finalFrame.origin.x = padding
            } else {
                initialFrame.origin.x = -initialFrame.width
            }
        case (.left, .center):
            if self.isPresenting {
                initialFrame.origin.x = -initialFrame.width
                finalFrame.origin.x = (containerView.bounds.width * 0.5) - (initialFrame.width * 0.5)
            } else {
                initialFrame.origin.x = -initialFrame.width
            }
        case (.left, .right(let padding)):
            if self.isPresenting {
                initialFrame.origin.x = -initialFrame.width
                finalFrame.origin.x = containerView.bounds.width - initialFrame.width - padding
            } else {
                initialFrame.origin.x = -initialFrame.width
            }
            
        // bottom entry
        case (.bottom, .top(let padding)):
            if self.isPresenting {
                initialFrame.origin.y = containerView.bounds.height
                finalFrame.origin.y = padding
            } else {
                finalFrame.origin.y = containerView.bounds.height
            }
        case (.bottom, .center):
            if self.isPresenting {
                initialFrame.origin.y = containerView.bounds.height
                finalFrame.origin.y = (containerView.bounds.height * 0.5) - (initialFrame.height * 0.5)
            } else {
                finalFrame.origin.y = containerView.bounds.height
            }
        case (.bottom, .bottom(let padding)):
            if self.isPresenting {
                initialFrame.origin.y = containerView.bounds.height
                finalFrame.origin.y = containerView.bounds.height - initialFrame.height - padding
            } else {
                finalFrame.origin.y = containerView.bounds.height
            }
            
        // right entry
        case (.right, .left(let padding)):
            if self.isPresenting {
                initialFrame.origin.x = containerView.bounds.width
                finalFrame.origin.x = padding
            } else {
                initialFrame.origin.x = containerView.bounds.width
            }
        case (.right, .center):
            if self.isPresenting {
                initialFrame.origin.x = containerView.bounds.width
                finalFrame.origin.x = (containerView.bounds.width * 0.5) - (initialFrame.width * 0.5)
            } else {
                initialFrame.origin.x = containerView.bounds.width
            }
        case (.right, .right(let padding)):
            if self.isPresenting {
                initialFrame.origin.x = containerView.bounds.width
                finalFrame.origin.x = containerView.bounds.width - initialFrame.width - padding
            } else {
                initialFrame.origin.x = containerView.bounds.width
            }
            
        default:
            return (.zero, .zero)
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
            transitionContext.containerView.addSubview(viewController.view)
        } else {
            viewController = transitionContext.viewController(forKey: .from)!
        }
        let initialFrame: CGRect = transitionContext.finalFrame(for: viewController)
        let frames: (initial: CGRect, final: CGRect) = self.frames(for: containerView, viewFrame: initialFrame)
        let animationDuration: TimeInterval = transitionDuration(using: transitionContext)
        viewController.view.frame = frames.initial
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut, animations: {
            viewController.view.frame = frames.final
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
}
