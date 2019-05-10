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
    
    let padding: CGFloat = 20
    
    func expectedOrigin(for position: ViewControllerOverlay.Position) -> CGPoint {
        let containerSize: CGSize = self.rootViewController.view.bounds.size
        let contentSize: CGSize = PresentedViewController.defaultSize
        switch position {
        case .top(let padding):
            return CGPoint(x: (containerSize.width - contentSize.width) * 0.5, y: padding)
        case .left(let padding):
            return CGPoint(x: padding, y: (containerSize.height - contentSize.height) * 0.5)
        case .center:
            return CGPoint(x: (containerSize.width - contentSize.width) * 0.5, y: (containerSize.height - contentSize.height) * 0.5)
        case .bottom(let padding):
            return CGPoint(x: (containerSize.width - contentSize.width) * 0.5, y: containerSize.height - contentSize.height - padding)
        case .right(let padding):
            return CGPoint(x: containerSize.width - contentSize.width - padding, y: (containerSize.height - contentSize.height) * 0.5)
        }
    }
    
    func showPresentedViewController(with overlay: ViewControllerOverlay, expectedOrigin: CGPoint) {
        self.rootViewController.transitionController = ViewControllerOverlayTransitionAnimationController(overlay: overlay)
        self.rootViewController.presentNewViewController(animated: true) { [weak self] in
            if let presentedViewController: UIViewController = self?.rootViewController.presentedViewController {
                let expectedSize: CGSize = PresentedViewController.defaultSize
                let expectedFrame: CGRect = CGRect(origin: expectedOrigin, size: expectedSize)
                XCTAssertEqual(expectedFrame, presentedViewController.view.frame)
                self?.expectation.fulfill()
            } else {
                XCTFail()
            }
        }
    }
    
    func testThatTopPositionOverlayHasCorrectFrame() {
        do {
            self.expectation = self.makeExpectation()
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .top, exit: .top, position: .top(self.padding))
            let expectedOrigin: CGPoint = self.expectedOrigin(for: overlay.position)
            self.showPresentedViewController(with: overlay, expectedOrigin: expectedOrigin)
            self.wait()
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThatLeftPositionOverlayHasCorrectFrame() {
        do {
            self.expectation = self.makeExpectation()
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .left, exit: .left, position: .left(self.padding))
            let expectedOrigin: CGPoint = self.expectedOrigin(for: overlay.position)
            self.showPresentedViewController(with: overlay, expectedOrigin: expectedOrigin)
            self.wait()
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThatCenterPositionOverlayHasCorrectFrame() {
        do {
            self.expectation = self.makeExpectation()
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .top, exit: .top, position: .center)
            let expectedOrigin: CGPoint = self.expectedOrigin(for: overlay.position)
            self.showPresentedViewController(with: overlay, expectedOrigin: expectedOrigin)
            self.wait()
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThatBottomPositionOverlayHasCorrectFrame() {
        do {
            self.expectation = self.makeExpectation()
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .bottom, exit: .bottom, position: .bottom(20))
            let expectedOrigin: CGPoint = self.expectedOrigin(for: overlay.position)
            self.showPresentedViewController(with: overlay, expectedOrigin: expectedOrigin)
            self.wait()
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThatRightPositionOverlayHasCorrectFrame() {
        do {
            self.expectation = self.makeExpectation()
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .right, exit: .right, position: .right(20))
            let expectedOrigin: CGPoint = self.expectedOrigin(for: overlay.position)
            self.showPresentedViewController(with: overlay, expectedOrigin: expectedOrigin)
            self.wait()
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
}
