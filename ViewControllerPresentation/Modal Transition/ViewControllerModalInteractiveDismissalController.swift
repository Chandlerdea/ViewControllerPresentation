//
//  ViewControllerModalInteractiveDismissalController.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 7/17/18.
//  Copyright © 2018 Chandlerdea. All rights reserved.
//

import Foundation

public protocol ViewControllerModalInteractiveDismissable {
    
    var interactiveTransitioning: ViewControllerModalInteractiveDismissalController? { get }
    func swipeDidBegin()
    func swipeDidEnd()
}

public final class ViewControllerModalInteractiveDismissalController: UIPercentDrivenInteractiveTransition {
    
    public static let percentThreshold: CGFloat = 0.3 // The user needs to swipe down 30% to trigger a dismissal
    
    public private(set) var interactionInProgress = false
    
    public private(set) var shouldCompleteTransition = false
    private weak var viewController: (UIViewController & ViewControllerModalInteractiveDismissable)!
    
    public init(viewController: UIViewController & ViewControllerModalInteractiveDismissable) {
        super.init()
        self.viewController = viewController
        self.prepareGestureRecognizer(in: self.viewController.view)
    }
    
    private func prepareGestureRecognizer(in view: UIView) {
        let recognizer: UIGestureRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(self.handleGesture(_:))
        )
        view.addGestureRecognizer(recognizer)
    }
    
    @objc func handleGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let percentThreshold: CGFloat = ViewControllerModalInteractiveDismissalController.percentThreshold
        let translation: CGPoint = recognizer.translation(in: self.viewController.view)
        let verticalMovement: CGFloat = translation.y / self.viewController.view.bounds.height
        let downwardMovement: Float = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent: Float = fminf(downwardMovement, 1.0)
        let progress: CGFloat = CGFloat(downwardMovementPercent)
        
        guard let viewController: UIViewController & ViewControllerModalInteractiveDismissable = self.viewController else { return }
        
        switch recognizer.state {
        case .began:
            viewController.swipeDidBegin()
            self.interactionInProgress = true
            viewController.dismiss(animated: true, completion: .none)
        case .changed:
            self.shouldCompleteTransition = progress > percentThreshold
            self.update(progress)
        case .cancelled:
            self.interactionInProgress = false
            self.cancel()
        case .ended:
            viewController.swipeDidEnd()
            self.interactionInProgress = false
            self.shouldCompleteTransition
                ? self.finish()
                : self.cancel()
        default:
            break
        }
    }
}
