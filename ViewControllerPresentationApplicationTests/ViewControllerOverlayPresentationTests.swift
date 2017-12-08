//
//  ViewControllerOverlayPresentationTests.swift
//  ViewControllerPresentationApplicationTests
//
//  Created by Chandler De Angelis on 12/7/17.
//  Copyright © 2017 Chandlerdea. All rights reserved.
//

import XCTest
import ViewControllerPresentation
@testable import ViewControllerPresentationApplication

class ViewControllerOverlayPresentationTests: ViewControllerDefaultPresentationTests {
    
    func showPresentedViewController(with placement: ViewControllerOverlayPlacement) {
        self.rootViewController.transitionController = ViewControllerOverlayTransitionAnimationController(placement: placement)
        let containerSize: CGSize = self.rootViewController.view.bounds.size
        self.rootViewController.presentNewViewController(animated: true) { [weak self] in
            if let presentedViewController: UIViewController = self?.rootViewController.presentedViewController {
                let expectedSize: CGSize = CGSize(width: PresentedViewController.defaultWidth, height: PresentedViewController.defaultHeight)
                var expectedOrigin: CGPoint = .zero
                expectedOrigin.x = (containerSize.width * 0.5) - (presentedViewController.view.bounds.width * 0.5)
                switch placement {
                case .top(let padding):
                    expectedOrigin.y = padding
                case .center:
                    expectedOrigin.y = (containerSize.height * 0.5) - (expectedSize.height * 0.5)
                case .bottom(let padding):
                    expectedOrigin.y = containerSize.height - expectedSize.height - padding
                }
                let expectedFrame: CGRect = CGRect(origin: expectedOrigin, size: expectedSize)
                XCTAssertEqual(expectedFrame, presentedViewController.view.frame)
                self?.expectation.fulfill()
            } else {
                XCTFail()
            }
        }
    }

    func testThatTopOverlayHasCorrectFrame() {
        self.showPresentedViewController(with: .top(20))
        self.wait()
    }
    
    func testThatCenterOverlayHasCorrectFrame() {
        self.showPresentedViewController(with: .center)
        self.wait()
    }
    
    func testThatBottomOverlayHasCorrectFrame() {
        self.showPresentedViewController(with: .bottom(20))
        self.wait()
    }
    
}
