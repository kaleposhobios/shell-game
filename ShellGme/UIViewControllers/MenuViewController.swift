//
//  MenuViewController.swift
//  ShellGme
//
//  Created by Matt Horst on 8/11/16.
//  Copyright © 2016 Test. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, MenuDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        navigationController?.setNavigationBarHidden(true, animated: false)

        let menuView = MenuView(frame: view.bounds)
        menuView.delegate = self
        view.addSubview(menuView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func newGamePressed() {
        if let nav = self.navigationController {
            let game = GameplayViewController(game: Game())
            nav.pushViewController(game, animated: true)
        }
    }

}

