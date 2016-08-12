//
//  Heartbeater.swift
//  ShellGme
//
//  Created by Matt Horst on 8/11/16.
//  Copyright © 2016 Test. All rights reserved.
//

import UIKit

/**
 * Takes a view and scales it to larger every few seconds
 */
class Heartbeater {
    private let view: UIView
    private var timer: NSTimer?

    init(view: UIView) {
        self.view = view
        timer = NSTimer.scheduledTimerWithTimeInterval(Constants.heartbeatInterval,
                                                       target: self,
                                                       selector: #selector(heartbeat),
                                                       userInfo: nil,
                                                       repeats: true)
    }

    @objc func heartbeat() {
        UIView.animateWithDuration(0.25,
            animations: {() in
                self.view.transform = CGAffineTransformMakeScale(1.5, 1.5)
            }, completion: {(completed) in
                UIView.animateWithDuration(0.25) {
                    self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
                }
            })
    }
}