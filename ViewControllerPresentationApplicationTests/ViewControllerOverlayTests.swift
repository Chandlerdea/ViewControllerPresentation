//
//  ViewControllerOverlayTests.swift
//  ViewControllerPresentationApplicationTests
//
//  Created by Chandler De Angelis on 12/7/17.
//  Copyright © 2017 Chandlerdea. All rights reserved.
//

import XCTest
import ViewControllerPresentation

class ViewControllerOverlayTests: XCTestCase {
    
    func testThaInvalidOverlayIsNotCreated() {
        // cannot enter from the top with a left position
        var overlay: ViewControllerOverlay? = try? ViewControllerOverlay(entry: .top, exit: .top, position: .left(0))
        XCTAssertNil(overlay)
        
        // cannot enter from the top with a right position
        overlay = try? ViewControllerOverlay(entry: .top, exit: .top, position: .right(0))
        XCTAssertNil(overlay)
        
        // cannot enter from the left with a top position
        overlay = try? ViewControllerOverlay(entry: .left, exit: .left, position: .top(0))
        XCTAssertNil(overlay)
        
        // cannot enter from the left with a bottom position
        overlay = try? ViewControllerOverlay(entry: .left, exit: .left, position: .bottom(0))
        XCTAssertNil(overlay)
        
        // cannot enter from the bottom with a left position
        overlay = try? ViewControllerOverlay(entry: .bottom, exit: .bottom, position: .left(0))
        XCTAssertNil(overlay)
        
        // cannot enter from the bottom with a right position
        overlay = try? ViewControllerOverlay(entry: .bottom, exit: .bottom, position: .right(0))
        XCTAssertNil(overlay)
        
        // cannot enter from the right with a top position
        overlay = try? ViewControllerOverlay(entry: .right, exit: .right, position: .top(0))
        XCTAssertNil(overlay)
        
        // cannot enter from the right with a bottom position
        overlay = try? ViewControllerOverlay(entry: .right, exit: .right, position: .bottom(0))
        XCTAssertNil(overlay)
        
        // cannot have a top position and exit to the left
        overlay = try? ViewControllerOverlay(entry: .top, exit: .top, position: .left(0))
        XCTAssertNil(overlay)
        
        // cannot have a top position and exit to the right
        overlay = try? ViewControllerOverlay(entry: .top, exit: .top, position: .right(0))
        XCTAssertNil(overlay)
        
        // cannot have a left position and exit to the top
        overlay = try? ViewControllerOverlay(entry: .top, exit: .left, position: .top(0))
        XCTAssertNil(overlay)
        
        // cannot have a left position and exit to the bottom
        overlay = try? ViewControllerOverlay(entry: .top, exit: .left, position: .bottom(0))
        XCTAssertNil(overlay)
        
        // cannot have a bottom position and exit to the left
        overlay = try? ViewControllerOverlay(entry: .top, exit: .bottom, position: .left(0))
        XCTAssertNil(overlay)
        
        // cannot have a bottom position and exit to the right
        overlay = try? ViewControllerOverlay(entry: .top, exit: .bottom, position: .right(0))
        XCTAssertNil(overlay)
        
        // cannot have a right position and exit to the top
        overlay = try? ViewControllerOverlay(entry: .top, exit: .right, position: .top(0))
        XCTAssertNil(overlay)
        
        // cannot have a right position and exit to the bottom
        overlay = try? ViewControllerOverlay(entry: .top, exit: .right, position: .bottom(0))
        XCTAssertNil(overlay)
    }
    
}
