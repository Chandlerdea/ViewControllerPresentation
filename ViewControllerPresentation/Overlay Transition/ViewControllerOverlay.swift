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
    
    public enum Edge {
        case top, left, bottom, right
    }
    
    public enum Position {
        case top(CGFloat)
        case left(CGFloat)
        case center
        case right(CGFloat)
        case bottom(CGFloat)
    }
    
    public let entry: Edge
    public let exit: Edge
    public let position: Position
    
    public init(entry: Edge, exit: Edge, position: Position) throws {
        switch (entry, position, exit) {
        case (.top, .left, _), // cannot enter from the top with a left position
             (.top, .right, _), // cannot enter from the top with a right position
             (.left, .top, _), // cannot enter from the left with a top position
             (.left, .bottom, _), // cannot enter from the left with a bottom position
             (.bottom, .left, _), // cannot enter from the bottom with a left position
             (.bottom, .right, _), // cannot enter from the bottom with a right position
             (.right, .top, _), // cannot enter from the right with a top position
             (.right, .bottom, _), // cannot enter from the right with a bottom position
             (_, .top, .left), // cannot have a top position and exit to the left
             (_, .top, .right), // cannot have a top position and exit to the right
             (_, .left, .top), // cannot have a left position and exit to the top
             (_, .left, .bottom), // cannot have a left position and exit to the bottom
             (_, .bottom, .left), // cannot have a bottom position and exit to the left
             (_, .bottom, .right), // cannot have a bottom position and exit to the right
             (_, .right, .top), // cannot have a right position and exit to the top
             (_, .right, .bottom): // cannot have a right position and exit to the bottom
            throw ViewControllerOverlayError.invalid
        default:
            self.entry = entry
            self.exit = exit
            self.position = position
        }
    }
}
