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
    let shellImage = UIImage(named: "shellfish")

    init(shell: Shell) {
        self.shell = shell
        let frame = CGRect(
            x: shell.center.x - floor(shell.bounds.size.width / 2),
            y: shell.center.y - floor(shell.bounds.size.height / 2),
            width: shell.bounds.width,
            height: shell.bounds.height
        )
        super.init(frame: frame)
        isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        shell.touched()
    }

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        shellImage?.draw(in: rect)

        // If the shell is selected, draw a green cicle inside of it
        if shell.hasButton && !shell.hideButton {
            UIColor(hex: 0xCDDC39).set()
            context?.fillEllipse(in: rect.insetBy(dx: rect.size.width / 4, dy: rect.size.height / 4))
        }
    }
}
