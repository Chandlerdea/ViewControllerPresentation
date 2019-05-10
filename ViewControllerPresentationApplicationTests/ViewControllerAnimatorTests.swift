//
//  ViewControllerAnimatorTests.swift
//  ViewControllerPresentationApplicationTests
//
//  Created by Chandler De Angelis on 12/7/17.
//  Copyright © 2017 Chandlerdea. All rights reserved.
//

import XCTest
import ViewControllerPresentation
@testable import ViewControllerPresentationApplication

class ViewControllerAnimatorTests: ViewControllerDefaultPresentationTests {
    
    func animatorPresents(with overlay: ViewControllerOverlay) {
        let viewFrame: CGRect = CGRect(origin: .zero, size: PresentedViewController.defaultSize)
        
        let presentingAnimator: ViewControllerOverlayAnimator = ViewControllerOverlayAnimator(overlay: overlay, isPresenting: true)
        let presentingFrames: (initial: CGRect, final: CGRect) = presentingAnimator.frames(for: self.rootViewController.view, viewFrame: viewFrame)
        switch overlay.entry {
        case .top:
            XCTAssertEqual(presentingFrames.initial.origin.y, -PresentedViewController.defaultSize.height)
        case .left:
            XCTAssertEqual(presentingFrames.initial.origin.x, -PresentedViewController.defaultSize.width)
        case .bottom:
            XCTAssertEqual(presentingFrames.initial.origin.y, self.rootViewController.view.bounds.height)
        case .right:
            XCTAssertEqual(presentingFrames.initial.origin.x, self.rootViewController.view.bounds.width)
        }
        
        let dismissingAnimator: ViewControllerOverlayAnimator = ViewControllerOverlayAnimator(overlay: overlay, isPresenting: false)
        let dismissingFrames: (initial: CGRect, final: CGRect) = dismissingAnimator.frames(for: self.rootViewController.view, viewFrame: viewFrame)
        switch overlay.exit {
        case .top:
            XCTAssertEqual(dismissingFrames.final.origin.y, -PresentedViewController.defaultSize.height)
        case .left:
            XCTAssertEqual(dismissingFrames.final.origin.x, -PresentedViewController.defaultSize.width)
        case .bottom:
            XCTAssertEqual(dismissingFrames.final.origin.y, self.rootViewController.view.bounds.height)
        case .right:
            XCTAssertEqual(dismissingFrames.final.origin.x, self.rootViewController.view.bounds.width)
        }
    }
    
    // MARK: - From Top
    
    func testThatAnimatorPresentsFromTopAndExitsLeft() {
        do {
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .top, exit: .left, position: .center)
            self.animatorPresents(with: overlay)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThatAnimatorPresentsFromTopAndExitsBottom() {
        do {
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .top, exit: .bottom, position: .center)
            self.animatorPresents(with: overlay)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThatAnimatorPresentsFromTopAndExitsRight() {
        do {
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .top, exit: .right, position: .center)
            self.animatorPresents(with: overlay)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThatAnimatorPresentsFromTopAndExitsTop() {
        do {
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .top, exit: .top, position: .center)
            self.animatorPresents(with: overlay)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    // MARK: - From Left
    
    func testThatAnimatorPresentsFromLeftAndExitsLeft() {
        do {
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .left, exit: .left, position: .center)
            self.animatorPresents(with: overlay)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThatAnimatorPresentsFromLeftAndExitsBottom() {
        do {
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .left, exit: .bottom, position: .center)
            self.animatorPresents(with: overlay)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThatAnimatorPresentsFromLeftAndExitsRight() {
        do {
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .left, exit: .right, position: .center)
            self.animatorPresents(with: overlay)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThatAnimatorPresentsFromLeftAndExitsTop() {
        do {
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .left, exit: .top, position: .center)
            self.animatorPresents(with: overlay)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    // MARK: - From Bottom
    
    func testThatAnimatorPresentsFromBottomAndExitsLeft() {
        do {
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .bottom, exit: .left, position: .center)
            self.animatorPresents(with: overlay)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThatAnimatorPresentsFromBottomAndExitsBottom() {
        do {
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .bottom, exit: .bottom, position: .center)
            self.animatorPresents(with: overlay)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThatAnimatorPresentsFromBottomAndExitsRight() {
        do {
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .bottom, exit: .right, position: .center)
            self.animatorPresents(with: overlay)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThatAnimatorPresentsFromBottomAndExitsTop() {
        do {
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .bottom, exit: .top, position: .center)
            self.animatorPresents(with: overlay)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    // MARK: - From Right
    
    func testThatAnimatorPresentsFromRightAndExitsLeft() {
        do {
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .right, exit: .left, position: .center)
            self.animatorPresents(with: overlay)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThatAnimatorPresentsFromRightAndExitsBottom() {
        do {
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .right, exit: .bottom, position: .center)
            self.animatorPresents(with: overlay)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThatAnimatorPresentsFromRightAndExitsRight() {
        do {
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .right, exit: .right, position: .center)
            self.animatorPresents(with: overlay)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThatAnimatorPresentsFromRightAndExitsTop() {
        do {
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .right, exit: .top, position: .center)
            self.animatorPresents(with: overlay)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
