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
    var shellViews = [ShellView]()

    init(frame: CGRect, game aGame: Game) {
        // Store the game it can be rendered
        game = aGame
        super.init(frame: frame)

        // Set up shell views to render the shell objects
        game.shells.forEach {
            let shell = ShellView(shell: $0)
            addSubview(shell)
            shellViews.append(shell)
        }
        // White background
        backgroundColor = .whiteColor()

        // Add a display link so the view updates along with scren refresh rate
        let displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
    }

    override init(frame: CGRect) {
        fatalError("Please use init(frame:game:)")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update() {
        for index in 0...game.shells.count - 1 {
            // Update the location of the shell view to match the shell's known location
            let shell = game.shells[index]
            let shellFrame = CGRectMake((shell.center.x - shell.bounds.width / 2), (shell.center.y - shell.bounds.height / 2), shell.bounds.width, shell.bounds.height)
            let view = shellViews[index]
            view.frame = shellFrame
            // And ask it to re-render
            view.setNeedsDisplay()
        }

    }
}
