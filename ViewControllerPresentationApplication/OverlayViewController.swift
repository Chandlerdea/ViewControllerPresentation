//
//  OverlayViewController.swift
//  ViewControllerPresentationApplication
//
//  Created by Chandler De Angelis on 12/7/17.
//  Copyright © 2017 Chandlerdea. All rights reserved.
//

import UIKit
import ViewControllerPresentation

class OverlayViewController: UIViewController, ViewControllerPresentable {
    
    static let defaultSize: CGSize = CGSize(width: 200, height: 200)

    public override var preferredContentSize: CGSize {
        get {
            return type(of: self).defaultSize
        }
        set {}
    }
    
    var customBackgroundView: UIView? {
        return .none
    }
    
    var backgroundColor: UIColor? {
        return UIColor.black.withAlphaComponent(0.2)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }

}
