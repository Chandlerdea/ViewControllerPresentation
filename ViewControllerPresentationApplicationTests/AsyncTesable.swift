//
//  AsyncTesable.swift
//  ViewControllerPresentationApplicationTests
//
//  Created by Chandler De Angelis on 12/7/17.
//  Copyright © 2017 Chandlerdea. All rights reserved.
//

import Foundation
import XCTest

protocol AsyncTestable {
    
    func makeExpectation() -> XCTestExpectation
    func wait(with timeout: TimeInterval)
}

extension AsyncTestable where Self: XCTestCase {
    
    func makeExpectation() -> XCTestExpectation {
        return self.expectation(description: "Async expectation")
    }
    
    func wait(with timeout: TimeInterval = 5) {
        self.waitForExpectations(timeout: timeout) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
}

extension XCTestCase: AsyncTestable {}
