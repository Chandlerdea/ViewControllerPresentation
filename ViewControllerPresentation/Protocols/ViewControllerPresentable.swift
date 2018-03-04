//
//  PresentingViewController.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 3/3/18.
//  Copyright © 2018 Chandlerdea. All rights reserved.
//

import Foundation
import UIKit

public protocol ViewControllerPresentable {
    
    var customBackgroundView: UIView? { get }
    var backgroundColor: UIColor? { get }
}

extension UIViewController: ViewControllerPresentable {
    
    public var customBackgroundView: UIView? {
        return .none
    }
    
    public var backgroundColor: UIColor? {
        return UIColor.black.withAlphaComponent(0.2)
    }

}
