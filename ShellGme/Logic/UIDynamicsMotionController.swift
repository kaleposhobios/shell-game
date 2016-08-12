//
//  UIDynamicsMotionController.swift
//  ShellGme
//
//  Created by Matt Horst on 8/11/16.
//  Copyright © 2016 Test. All rights reserved.
//

import UIKit

/**
 * Gives motion to the shells
 */
struct UIDynamicsMotionController : MotionController {

    let shells: [Shell]
    var animator: UIDynamicAnimator

    init(referenceView: UIView, shells: [Shell]) {
        self.shells = shells
        // Set initial positions for the shells
        let x: Double = floor(Double(referenceView.bounds.width) / 2)
        let totalShellHeight = Constants.shellHeight * Double(Constants.numShells) +
            (Constants.shellYSpacer * Double(Constants.numShells - 1))
        var y: Double = floor((Double(referenceView.bounds.height) - totalShellHeight) / 2)
        for shell in shells {
            shell.setStartPosition(position: CGPoint(x: x, y: y))
            y += Constants.shellHeight + Constants.shellYSpacer
        }

        // Set up dynamic motion behavior for the shells
        animator = UIDynamicAnimator(referenceView: referenceView)

        let collision = UICollisionBehavior()
        collision.translatesReferenceBoundsIntoBoundary = true
        for shell in shells {
            collision.addItem(shell)
        }
        animator.addBehavior(collision)

        let behavior = UIDynamicItemBehavior(items: shells)
        behavior.elasticity = 1
        behavior.density = 1
        animator.addBehavior(behavior)
    }

    func startMotion() {
        // Do some pushes on the shells

        for shell in shells {
            var range = (0, 360)
            let angle = CGFloat(arc4random_uniform(UInt32(range.1 - range.0) + 1) + UInt32(range.0))
            range = (0, 100)
            let magnitude = CGFloat(arc4random_uniform(UInt32(range.1 - range.0) + 1) + UInt32(range.0))
            let push = UIPushBehavior(items: [shell], mode: .Instantaneous)
            push.setAngle(angle, magnitude: magnitude / 50)
            print("pushing with angle: \(angle) and magnitude \(magnitude)")
            animator.addBehavior(push)
        }

    }
}