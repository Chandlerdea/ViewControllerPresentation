//
//  ViewControllerPeekPresentable.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 5/9/19.
//  Copyright © 2019 Chandlerdea. All rights reserved.
//

import Foundation
import UIKit

public protocol ViewControllerPeekPresentable: ViewControllerPresentable {
    var backgroundHeight: CGFloat { get }
}

extension ViewControllerPeekPresentable where Self: UIViewController {
    
    public var backgroundHeight: CGFloat {
        return 20
    }

    public var preferredContentHeight: CGFloat {
        var result: CGFloat = UIScreen.main.bounds.height
        if #available(iOS 11.0, *) {
            result -= (self.backgroundHeight + self.view.safeAreaInsets.top)
        } else {
            result -= self.backgroundHeight
        }
        return result
    }

}
