//
//  Point.swift
//  ShellGme
//
//  Created by Matt Horst on 8/11/16.
//  Copyright © 2016 Test. All rights reserved.
//

import UIKit

extension CGPoint : Point {
    func x() -> Double {
        return Double(self.x)
    }

    func y() -> Double {
        return Double(self.y)
    }
}

/**
 * Defines a point (outside of UIKit)
 */
protocol Point {
    func x() -> Double
    func y() -> Double
}

struct ShellPoint: Point {
    var xPosition: Double
    var yPosition: Double

    func x() -> Double {
        return xPosition
    }

    func y() -> Double {
        return yPosition
    }
}