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

