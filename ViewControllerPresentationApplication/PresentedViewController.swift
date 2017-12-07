//
//  PresentedViewController.swift
//  ViewControllerPresentationApplication
//
//  Created by Chandler De Angelis on 12/7/17.
//  Copyright © 2017 Chandlerdea. All rights reserved.
//

import UIKit

class PresentedViewController: UIViewController {
    
    static let defaultWidth: CGFloat = 200
    static let defaultHeight: CGFloat = 200

    public override var preferredContentSize: CGSize {
        get {
            return CGSize(width: type(of: self).defaultWidth, height: type(of: self).defaultHeight)
        }
        set {}
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }

}
