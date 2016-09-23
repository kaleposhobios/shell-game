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
    fileprivate let view: UIView
    fileprivate var timer: Timer?

    init(view: UIView) {
        self.view = view
        timer = Timer.scheduledTimer(timeInterval: Constants.heartbeatInterval,
                                                       target: self,
                                                       selector: #selector(heartbeat),
                                                       userInfo: nil,
                                                       repeats: true)
    }

    @objc func heartbeat() {
        UIView.animate(withDuration: 0.25,
            animations: {() in
                self.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: {(completed) in
                UIView.animate(withDuration: 0.25, animations: {
                    self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }) 
            })
    }
}
