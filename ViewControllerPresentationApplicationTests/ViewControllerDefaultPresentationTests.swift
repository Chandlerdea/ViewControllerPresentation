//
//  ViewControllerDefaultPresentationTests.swift
//  ViewControllerPresentationApplicationTests
//
//  Created by Chandler De Angelis on 12/7/17.
//  Copyright © 2017 Chandlerdea. All rights reserved.
//

import XCTest

@testable import ViewControllerPresentationApplication

class ViewControllerDefaultPresentationTests: XCTestCase {
    
    var expectation: XCTestExpectation!
    var rootViewController: RootViewController!
    
    override func setUp() {
        super.setUp()
        self.rootViewController = (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController as! RootViewController
        self.expectation = self.makeExpectation()
    }
    
}
