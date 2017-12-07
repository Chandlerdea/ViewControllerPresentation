//
//  ViewControllerPresentationApplicationTests.swift
//  ViewControllerPresentationApplicationTests
//
//  Created by Chandler De Angelis on 12/7/17.
//  Copyright © 2017 Chandlerdea. All rights reserved.
//

import XCTest
@testable import ViewControllerPresentationApplication

class ViewControllerPresentationApplicationTests: XCTestCase {
    
    var expectation: XCTestExpectation!
    var rootViewController: RootViewController!
    
    override func setUp() {
        super.setUp()
        self.rootViewController = (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController as! RootViewController
    }
    
    func testThatNewViewControllerCanBePresented() {
        self.expectation = self.expectation(description: "show new view controller")
        self.rootViewController.presentNewViewController(animated: true) { [weak self] in
            if let presentedViewController: UIViewController = self?.rootViewController.presentedViewController {
                XCTAssertTrue(presentedViewController is PresentedViewController)
            } else {
                XCTFail()
            }
            self?.expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testThatNewViewControllerIsCorrectSize() {
        self.expectation = self.expectation(description: "test view controller size")
        self.rootViewController.presentNewViewController(animated: true) { [weak self] in
            if let presentedViewController: UIViewController = self?.rootViewController.presentedViewController {
                let expectedSize: CGSize = CGSize(width: PresentedViewController.defaultWidth, height: PresentedViewController.defaultHeight)
                XCTAssertEqual(expectedSize, presentedViewController.view.bounds.size)
            } else {
                XCTFail()
            }
            self?.expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testThatNewViewControllerCanBeDismissed() {
        self.expectation = self.expectation(description: "dismiss view controller")
        self.rootViewController.presentNewViewController(animated: true) { [weak self] in
            self?.rootViewController.didTapContainer()
            // The dismissal is animated, so force a wait
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(1), execute: {
                XCTAssertNil(self?.rootViewController.presentedViewController)
                self?.expectation.fulfill()
            })
        }
        self.waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
}
