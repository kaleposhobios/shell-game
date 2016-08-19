//
//  GameplayViewController.swift
//  ShellGme
//
//  Created by Matt Horst on 8/11/16.
//  Copyright © 2016 Test. All rights reserved.
//

import UIKit

enum PregameStates : Int {
    case PregameCountdown3 = 0
    case PregameCountdown2 = 1
    case PregameCountdown1 = 2
    case PregameCountdown0 = 3
}
class GameplayViewController: UIViewController, UIAlertViewDelegate {

    var gameBoard: GameBoardView?
    let game: Game
    var pregameState = PregameStates.PregameCountdown3
    let countdownLabel = UILabel(frame: CGRect.zero)
    var timer: NSTimer?

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

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(userFoundButton), name: Constants.ShellWithButtonTappedKey, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(userFailedButton), name: Constants.ShellWithoutButtonTappedKey, object: nil)
        countdownLabel.shadowColor = UIColor(hex: 0xCDDC39)
        countdownLabel.textColor = .whiteColor()
        countdownLabel.shadowOffset = CGSize(width: 3, height: 3)
        countdownLabel.font = UIFont.boldSystemFontOfSize(100)
        view.addSubview(countdownLabel)
        setupForPregameState()

        // Use timer to show countdown
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(advancePregameState), userInfo: nil, repeats: true)
    }

    func advancePregameState() {
        let currentState = pregameState.rawValue
        pregameState = PregameStates.init(rawValue: currentState + 1)!
        setupForPregameState()
    }

    func setupForPregameState() {
        countdownLabel.transform = CGAffineTransformIdentity
        countdownLabel.hidden = false
        switch pregameState {
        case .PregameCountdown3:
            countdownLabel.text = "3"
        case .PregameCountdown2:
            countdownLabel.text = "2"
        case .PregameCountdown1:
            countdownLabel.text = "1"
        default:
            // Start game
            countdownLabel.text = "GO!"
            timer?.invalidate()
            game.startGame()
        }

        countdownLabel.sizeToFit()
        countdownLabel.center = view.center
        UIView.animateWithDuration(0.8, animations: {
            self.countdownLabel.transform = CGAffineTransformMakeScale(0.01, 0.01)
            })
        { (completed) in
            self.countdownLabel.hidden = true
        }
    }

    func userFoundButton() {
        UIAlertView(title: "YOU FOUND ME", message: nil, delegate: self, cancelButtonTitle: "OK").show()
    }

    func userFailedButton() {
        UIAlertView(title: "FAIL WHALE", message: nil, delegate: self, cancelButtonTitle: "OK").show()
    }

    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        navigationController?.popViewControllerAnimated(true)
    }
}
