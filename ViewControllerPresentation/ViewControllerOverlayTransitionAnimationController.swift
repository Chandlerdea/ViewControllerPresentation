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
    
    private let placement: ViewControllerOverlayPlacement
    
    // MARK: - Init
    
    public init(placement: ViewControllerOverlayPlacement) {
        self.placement = placement
        super.init()
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    
    public override func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let result: ViewControllerOverlayTransitionPresentationController = ViewControllerOverlayTransitionPresentationController(
            placement: self.placement,
            presentedViewController: presented,
            presenting: presenting
        )
        result.tapDelegate = self.tapDelegate
        return result
    }
}
