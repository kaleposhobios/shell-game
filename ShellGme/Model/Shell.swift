//
//  Shell.swift
//  ShellGme
//
//  Created by Matt Horst on 8/11/16.
//  Copyright © 2016 Test. All rights reserved.
//

import UIKit

/**
 * Defines a shell. Tracks its position and if it has a button inside it or not
 */
@objc class Shell : NSObject, UIDynamicItem {

    var center: CGPoint
    var bounds: CGRect
    var transform: CGAffineTransform

    var hasButton: Bool = false
    var hideButton: Bool = false

    init(hasButton button: Bool) {
        // Set up defaults
        hasButton = button
        bounds = CGRect.zero
        center = CGPoint.zero
        transform = CGAffineTransform.identity
        super.init()
    }

    func setStartPosition(position startPosition: Point) {
        // Set center and bounds based on given start position and constants for shell width and height
        center = CGPoint(x: CGFloat(startPosition.x()), y: CGFloat(startPosition.y()))
        bounds = CGRect(x: CGFloat(startPosition.x()), y: CGFloat(startPosition.y()), width: CGFloat(Constants.shellWidth), height: CGFloat(Constants.shellHeight))
    }

    func touched() {
        if hideButton {
            var key: String?
            if hasButton {
                key = Constants.ShellWithButtonTappedKey
            } else {
                key = Constants.ShellWithoutButtonTappedKey
            }
            NotificationCenter.default.post(name: Notification.Name(rawValue: key!), object: nil)
        }
    }

}
