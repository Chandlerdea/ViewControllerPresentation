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
    
    private let overlay: ViewControllerOverlay
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let containerSize: CGSize = self.containerView?.bounds.size ?? UIScreen.main.bounds.size
        var frame: CGRect = super.frameOfPresentedViewInContainerView
        switch self.overlay.position {
        case .top(let padding):
            frame.origin.y = padding
            frame.origin.x = (containerSize.width * 0.5) - (frame.width * 0.5)
        case .left(let padding):
            frame.origin.x = padding
            frame.origin.y = (containerSize.height * 0.5) - (frame.height * 0.5)
        case .center:
            frame.origin.y = (containerSize.height * 0.5) - (frame.width * 0.5)
            frame.origin.x = (containerSize.width * 0.5) - (frame.width * 0.5)
        case .right(let padding):
            frame.origin.x = containerSize.width - frame.width - padding
            frame.origin.y = (containerSize.height * 0.5) - (frame.height * 0.5)
        case .bottom(let padding):
            frame.origin.y = containerSize.height - frame.height - padding
            frame.origin.x = (containerSize.width * 0.5) - (frame.width * 0.5)
        }
        return frame
    }
    
    // MARK: - Init
    
    init(overlay: ViewControllerOverlay, backgroundColor: UIColor, presentedViewController: UIViewController, presenting: UIViewController?) {
        self.overlay = overlay
        super.init(backgroundColor: backgroundColor, presentedViewController: presentedViewController, presenting: presenting)
    }
}
