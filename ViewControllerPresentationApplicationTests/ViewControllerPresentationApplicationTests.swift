//
//  ViewControllerPresentationApplicationTests.swift
//  ViewControllerPresentationApplicationTests
//
//  Created by Chandler De Angelis on 12/7/17.
//  Copyright © 2017 Chandlerdea. All rights reserved.
//

import XCTest
import ViewControllerPresentation
@testable import ViewControllerPresentationApplication

class ViewControllerPresentationApplicationTests: ViewControllerDefaultPresentationTests {
    
    override func setUp() {
        super.setUp()
        self.rootViewController.transitionController = ViewControllerDefaultTransitionAnimationController()
    }
    
    func testThatNewViewControllerCanBePresented() {
        self.expectation = self.makeExpectation()
        self.rootViewController.presentNewViewController(animated: true) { [weak self] in
            if let presentedViewController: UIViewController = self?.rootViewController.presentedViewController {
                XCTAssertTrue(presentedViewController is PresentedViewController)
            } else {
                XCTFail()
            }
            self?.expectation.fulfill()
        }
        self.wait()
    }
    
    func testThatNewViewControllerIsCorrectSize() {
        self.expectation = self.makeExpectation()
        self.rootViewController.presentNewViewController(animated: true) { [weak self] in
            if let presentedViewController: UIViewController = self?.rootViewController.presentedViewController {
                let expectedSize: CGSize = CGSize(width: PresentedViewController.defaultWidth, height: PresentedViewController.defaultHeight)
                XCTAssertEqual(expectedSize, presentedViewController.view.bounds.size)
            } else {
                XCTFail()
            }
            self?.expectation.fulfill()
        }
        self.wait()
    }
    
    func testThatNewViewControllerCanBeDismissed() {
        self.expectation = self.makeExpectation()
        self.rootViewController.presentNewViewController(animated: true) { [weak self] in
            self?.rootViewController.didTapContainer()
            // The dismissal is animated, so force a wait
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(1), execute: {
                XCTAssertNil(self?.rootViewController.presentedViewController)
                self?.expectation.fulfill()
            })
        }
        self.wait()
    }
}
