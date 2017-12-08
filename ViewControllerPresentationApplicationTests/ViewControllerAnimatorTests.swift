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
        let animator: ViewControllerOverlayAnimator = ViewControllerOverlayAnimator(overlay: overlay, isPresenting: true)
        let viewFrame: CGRect = CGRect(origin: .zero, size: CGSize(width: PresentedViewController.defaultWidth, height: PresentedViewController.defaultHeight))
        let frames: (initial: CGRect, final: CGRect) = animator.frames(for: self.rootViewController.view, viewFrame: viewFrame)
        switch overlay.entry {
        case .top:
            XCTAssertEqual(frames.initial.origin.y, -PresentedViewController.defaultHeight)
        case .left:
            XCTAssertEqual(frames.initial.origin.x, -PresentedViewController.defaultWidth)
        case .bottom:
            XCTAssertEqual(frames.initial.origin.y, self.rootViewController.view.bounds.height)
        case .right:
            XCTAssertEqual(frames.initial.origin.x, self.rootViewController.view.bounds.width)
        }
    }
    
    func testThatAnimatorPresentsFromTop() {
        do {
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .top, position: .top(0))
            self.animatorPresents(with: overlay)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThatAnimatorPresentsFromLeft() {
        do {
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .left, position: .left(0))
            self.animatorPresents(with: overlay)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThatAnimatorPresentsFromBottom() {
        do {
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .bottom, position: .bottom(0))
            self.animatorPresents(with: overlay)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThatAnimatorPresentsFromRight() {
        do {
            let overlay: ViewControllerOverlay = try ViewControllerOverlay(entry: .right, position: .right(0))
            self.animatorPresents(with: overlay)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
