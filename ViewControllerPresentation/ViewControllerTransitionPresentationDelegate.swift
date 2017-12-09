//
//  ViewControllerTransitionPresentationDelegate.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 12/7/17.
//  Copyright © 2017 Chandlerdea. All rights reserved.
//

import Foundation

public protocol ViewControllerTransitionPresentationDelegate: class {
    func didTapContainer()
}

extension ViewControllerTransitionPresentationDelegate where Self: UIViewController {
    
    public func didTapContainer() {
        self.presentedViewController?.dismiss(animated: true, completion: .none)
    }
}

extension UIViewController: ViewControllerTransitionPresentationDelegate {}

