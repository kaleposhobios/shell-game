//
//  GameBoardView.swift
//  ShellGme
//
//  Created by Matt Horst on 8/11/16.
//  Copyright © 2016 Test. All rights reserved.
//

import UIKit

/**
 * Handles rendering the game
 */
class GameBoardView: UIView {
    let game: Game

    init(frame: CGRect, game aGame: Game) {
        // Store the game it can be rendered
        game = aGame
        super.init(frame: frame)

        backgroundColor = .whiteColor()

        // Add a display link which ties the update method to setNeedsDisplay(),
        // so the view renders along with scren refresh rate
        let displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
    }

    override init(frame: CGRect) {
        fatalError("Please use init(frame:game:)")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawRect(rect: CGRect) {
        // Get context for drawing
        let context = UIGraphicsGetCurrentContext()
        for shell in game.shells {
            let rect = CGRect(
                x: shell.center.x - floor(shell.bounds.size.width / 2),
                y: shell.center.y - floor(shell.bounds.size.height / 2),
                width: shell.bounds.width,
                height: shell.bounds.height
            )
            // Draw the shell as a blue rectangle
            UIColor.blueColor().set()
            CGContextFillRect(context, rect)
            // If the shell is selected, draw a green cicle inside of it
            if shell.hasButton && game.showingButton {
                UIColor.greenColor().set()
                CGContextFillEllipseInRect(context, rect)
            }
        }
    }

    func update() {
        // CADisplayLink timer, trigger render
        setNeedsDisplay()
    }
}
