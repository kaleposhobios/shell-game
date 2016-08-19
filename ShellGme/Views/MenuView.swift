//
//  MenuView.swift
//  ShellGme
//
//  Created by Matt Horst on 8/11/16.
//  Copyright © 2016 Test. All rights reserved.
//

import UIKit

protocol MenuDelegate {
    func newGamePressed()
}

/**
 * View for the menu
 */
class MenuView: UIView {

    var delegate: MenuDelegate?
    let newGameButton: UIButton = UIButton(type: .System)
    var heartbeater: Heartbeater?

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .whiteColor()

        // Set up title and new game button
        let title = UILabel(frame: CGRect.zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "SHELL\nWE\nPLAY\nA\nGAME?"
        title.textAlignment = .Center
        title.font = UIFont.boldSystemFontOfSize(20)
        title.numberOfLines = 0
        title.textColor = UIColor(hex: 0x303F9F)
        addSubview(title)
        let titleX = NSLayoutConstraint(item: title, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0)

        addSubview(newGameButton)
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        newGameButton.setTitle("LET'S PLAY", forState: .Normal)
        newGameButton.titleLabel?.font = UIFont.boldSystemFontOfSize(20)
        newGameButton.setTitleColor(UIColor(hex: 0x303F9F), forState: .Normal)
        newGameButton.addTarget(self, action: #selector(buttonPressed(_:)), forControlEvents: .TouchUpInside)
        let buttonX = NSLayoutConstraint(item: newGameButton, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0)
        let buttonWidth = NSLayoutConstraint(item: newGameButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 200)
        var constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[title]-100-[button(30)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["button": newGameButton, "title": title])
        constraints.append(titleX)
        constraints.append(buttonX)
        constraints.append(buttonWidth)
        NSLayoutConstraint.activateConstraints(constraints)

        // Make a heartbeater with the new game button to make it look cool
        heartbeater = Heartbeater(view: newGameButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buttonPressed(sender: UIButton) {
        // Let delegate know the new game button was pressed
        if let delegate = delegate {
            delegate.newGamePressed()
        }
    }

}
