//
//  ViewControlllerTransitionAnimationController.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 12/06/17.
//

import UIKit

public class ViewControllerDefaultTransitionAnimationController: NSObject, UIViewControllerTransitioningDelegate {

    // MARK: - Properties

    public weak var tapDelegate: ViewControllerTransitionPresentationDelegate?
    public var backgroundColor: UIColor? = UIColor.black.withAlphaComponent(0.2)
    public var customBackgroundView: UIView?

    // MARK: UIViewControllerTransitioningDelegate

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let result: ViewControllerDefaultTransitionPresentationController = ViewControllerDefaultTransitionPresentationController(
            backgroundColor: self.backgroundColor,
            backgroundView: self.customBackgroundView,
            presentedViewController: presented,
            presenting: presenting
        )
        result.tapDelegate = self.tapDelegate
        return result
    }
}
