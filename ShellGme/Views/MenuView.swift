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
    let newGameButton: UIButton = UIButton(type: .system)
    var heartbeater: Heartbeater?

    override init(frame: CGRect) {
        super.init(frame: frame)

//        backgroundColor = UIColor

        // Set up title and new game button
        let title = UILabel(frame: CGRect.zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "SHELL\nWE\nPLAY\nA\nGAME?"
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.numberOfLines = 0
        title.textColor = UIColor(hex: 0x303F9F)
        addSubview(title)
        let titleX = NSLayoutConstraint(item: title, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)

        addSubview(newGameButton)
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        newGameButton.setTitle("LET'S PLAY", for: UIControlState())
        newGameButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        newGameButton.setTitleColor(UIColor(hex: 0x303F9F), for: UIControlState())
        newGameButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        let buttonX = NSLayoutConstraint(item: newGameButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let buttonWidth = NSLayoutConstraint(item: newGameButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[title]-100-[button(30)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["button": newGameButton, "title": title])
        constraints.append(titleX)
        constraints.append(buttonX)
        constraints.append(buttonWidth)
        NSLayoutConstraint.activate(constraints)

        // Make a heartbeater with the new game button to make it look cool
        heartbeater = Heartbeater(view: newGameButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buttonPressed(_ sender: UIButton) {
        // Let delegate know the new game button was pressed
        if let delegate = delegate {
            delegate.newGamePressed()
        }
    }

}
