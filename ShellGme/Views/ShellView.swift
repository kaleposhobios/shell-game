//
//  ShellView.swift
//  ShellGme
//
//  Created by Matt Horst on 8/12/16.
//  Copyright © 2016 Test. All rights reserved.
//

import UIKit

class ShellView : UIView {
    let shell: Shell

    init(shell: Shell) {
        self.shell = shell
        let frame = CGRect(
            x: shell.center.x - floor(shell.bounds.size.width / 2),
            y: shell.center.y - floor(shell.bounds.size.height / 2),
            width: shell.bounds.width,
            height: shell.bounds.height
        )
        super.init(frame: frame)
        opaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        shell.touched()
    }

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        UIColor.blueColor().set()
        CGContextFillRect(context, rect)

        // If the shell is selected, draw a green cicle inside of it
        if shell.hasButton && !shell.hideButton {
            UIColor.greenColor().set()
            CGContextFillEllipseInRect(context, CGRectInset(rect, rect.size.width / 4, rect.size.height / 4))
        }

    }
}
