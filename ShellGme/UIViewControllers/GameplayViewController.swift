//
//  GameplayViewController.swift
//  ShellGme
//
//  Created by Matt Horst on 8/11/16.
//  Copyright © 2016 Test. All rights reserved.
//

import UIKit

class GameplayViewController: UIViewController {

    var gameBoard: GameBoardView?
    let game: Game

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        fatalError("Plesae use init(game:)")
    }

    init(game aGame: Game) {
        game = aGame

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor()

        // Make a game board view and add it to self.view
        gameBoard = GameBoardView(frame: view.bounds, game: game)
        view.addSubview(gameBoard!)

        // Give a motion controller to control the shells movement
        game.motionController = UIDynamicsMotionController(referenceView: gameBoard!, shells: game.shells)
        game.startGame()
    }
}
