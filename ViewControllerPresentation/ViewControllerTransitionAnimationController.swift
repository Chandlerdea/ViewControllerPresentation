//
//  ViewControlllerTransitionAnimationController.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 12/06/17.
//

import UIKit

public final class ViewControlllerTransitionAnimationController: NSObject, UIViewControllerTransitioningDelegate {

    // MARK: - Properties

    public weak var tapDelegate: ViewControllerTransitionPresentationDelegate?

    // MARK: UIViewControllerTransitioningDelegate

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let result: ViewControllerTransitionPresentationController = ViewControllerTransitionPresentationController(presentedViewController: presented, presenting: presenting)
        result.tapDelegate = self.tapDelegate
        return result
    }
}
