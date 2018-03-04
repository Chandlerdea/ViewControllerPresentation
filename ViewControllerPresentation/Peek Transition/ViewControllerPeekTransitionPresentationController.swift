//
//  ViewControllerPeekTransitionPresentationController.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 3/3/18.
//  Copyright © 2018 Chandlerdea. All rights reserved.
//

import UIKit

final class ViewControllerPeekTransitionPresentationController: ViewControllerDefaultTransitionPresentationController {

    override var frameOfPresentedViewInContainerView: CGRect {
        let yOrigin: CGFloat = UIScreen.main.bounds.height - self.presentedViewController.preferredContentSize.height
        return CGRect(
            x: 0,
            y: yOrigin,
            width: self.presentedViewController.preferredContentSize.width,
            height: self.presentedViewController.preferredContentSize.height
        )
    }
}
