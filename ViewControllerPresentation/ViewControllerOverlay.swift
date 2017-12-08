//
//  ViewControllerOverlay.swift
//  ViewControllerPresentation
//
//  Created by Chandler De Angelis on 12/7/17.
//  Copyright © 2017 Chandlerdea. All rights reserved.
//

import Foundation

public enum ViewControllerOverlayError: Error {
    case invalid
}

public struct ViewControllerOverlay {
    
    public enum Entry {
        case top, left, bottom, right
    }
    
    public enum Position {
        case top(CGFloat)
        case left(CGFloat)
        case center
        case right(CGFloat)
        case bottom(CGFloat)
    }
    
    public let entry: Entry
    public let position: Position
    
    public init(entry: Entry, position: Position) throws {
        switch (entry, position) {
        case (.top, .left),
             (.top, .right),
             (.left, .top),
             (.left, .bottom),
             (.bottom, .left),
             (.bottom, .right),
             (.right, .top),
             (.right, .bottom):
            throw ViewControllerOverlayError.invalid
        default:
            self.entry = entry
            self.position = position
        }
    }
}
