//
//  ViewControllerAnimator.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 5/9/19.
//  Copyright © 2019 Chandlerdea. All rights reserved.
//

import UIKit

class ViewControllerAnimator: NSObject {

    // MARK: - Properties

    let isPresenting: Bool
    
    // MARK: - Init
    
    public init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }

}
