//
//  ViewControllerOverlayTransitionPresentationController.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 12/7/17.
//  Copyright © 2017 Chandlerdea. All rights reserved.
//

import Foundation

final class ViewControllerOverlayTransitionPresentationController: ViewControllerDefaultTransitionPresentationController {
    
    // MARK: - Properties
    
    let placement: ViewControllerOverlayPlacement
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let containerSize: CGSize = self.containerView?.bounds.size ?? UIScreen.main.bounds.size
        var frame: CGRect = super.frameOfPresentedViewInContainerView
        switch self.placement {
        case .top(let padding):
            frame.origin.y = padding
        case .center:
            frame.origin.y = (containerSize.height * 0.5) - (frame.width * 0.5)
        case .bottom(let padding):
            frame.origin.y = containerSize.height - frame.height - padding
        }
        return frame
    }
    
    // MARK: - Init
    
    init(placement: ViewControllerOverlayPlacement, presentedViewController: UIViewController, presenting: UIViewController?) {
        self.placement = placement
        super.init(presentedViewController: presentedViewController, presenting: presenting)
    }
}
