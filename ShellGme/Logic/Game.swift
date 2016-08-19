//
//  Game.swift
//  ShellGme
//
//  Created by Matt Horst on 8/11/16.
//  Copyright © 2016 Test. All rights reserved.
//

import Foundation

/**
 * Controls game logic. Tracks the shells.
 */
class Game {
    var shells = [Shell]()
    var motionController: MotionController?
    var showingButton = true

    init() {
        // Set up all the shells
        let range = (1, Constants.numShells)
        let hasButton = Int(arc4random_uniform(UInt32(range.1 - range.0) + 1) + UInt32(range.0))
        for item in 1...Constants.numShells {
            let shell = Shell(hasButton: item == hasButton)
            shells.append(shell)
        }
    }

    func startGame() {
        if let motionController = self.motionController {
            motionController.startMotion()
        }
        self.shells.forEach { $0.hideButton = true }
    }

}