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

    // MARK: UIViewControllerTransitioningDelegate

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        guard let presentable: ViewControllerPresentable & UIViewController = presented as? (UIViewController & ViewControllerPresentable) else {
            return .none
        }
        let result: ViewControllerDefaultTransitionPresentationController = ViewControllerDefaultTransitionPresentationController(
            presentedViewController: presentable,
            presenting: presenting
        )
        result.tapDelegate = self.tapDelegate
        return result
    }
}
