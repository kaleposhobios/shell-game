//
//  GameplayViewController.swift
//  ShellGme
//
//  Created by Matt Horst on 8/11/16.
//  Copyright © 2016 Test. All rights reserved.
//

import UIKit

enum PregameStates : Int {
    case pregameCountdown3 = 0
    case pregameCountdown2 = 1
    case pregameCountdown1 = 2
    case pregameCountdown0 = 3
}
class GameplayViewController: UIViewController {

    var gameBoard: GameBoardView?
    let game: Game
    var pregameState = PregameStates.pregameCountdown3
    let countdownLabel = UILabel(frame: CGRect.zero)
    var timer: Timer?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
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
        view.backgroundColor = .white

        // Make a game board view and add it to self.view
        gameBoard = GameBoardView(frame: view.bounds, game: game)
        view.addSubview(gameBoard!)

        // Give a motion controller to control the shells movement
        game.motionController = UIDynamicsMotionController(referenceView: gameBoard!, shells: game.shells)

        NotificationCenter.default.addObserver(self, selector: #selector(userFoundButton), name: NSNotification.Name(rawValue: Constants.ShellWithButtonTappedKey), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userFailedButton), name: NSNotification.Name(rawValue: Constants.ShellWithoutButtonTappedKey), object: nil)
        countdownLabel.shadowColor = UIColor(hex: 0xCDDC39)
        countdownLabel.textColor = .white
        countdownLabel.shadowOffset = CGSize(width: 3, height: 3)
        countdownLabel.font = UIFont.boldSystemFont(ofSize: 100)
        view.addSubview(countdownLabel)
        setupForPregameState()

        // Use timer to show countdown
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(advancePregameState), userInfo: nil, repeats: true)
    }

    func advancePregameState() {
        let currentState = pregameState.rawValue
        pregameState = PregameStates.init(rawValue: currentState + 1)!
        setupForPregameState()
    }

    func setupForPregameState() {
        countdownLabel.transform = CGAffineTransform.identity
        countdownLabel.isHidden = false
        switch pregameState {
        case .pregameCountdown3:
            countdownLabel.text = "3"
        case .pregameCountdown2:
            countdownLabel.text = "2"
        case .pregameCountdown1:
            countdownLabel.text = "1"
        default:
            // Start game
            countdownLabel.text = "GO!"
            timer?.invalidate()
            game.startGame()
        }

        countdownLabel.sizeToFit()
        countdownLabel.center = view.center
        UIView.animate(withDuration: 0.8, animations: {
            self.countdownLabel.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            }, completion: { (completed) in
            self.countdownLabel.isHidden = true
        })
        
    }

    func userFoundButton() {
        let alert = UIAlertController(title: "YOU FOUND ME", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }))
        show(alert, sender: self)
    }

    func userFailedButton() {
        let alert = UIAlertController(title: "FAIL WHALE", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }))
        show(alert, sender: self)
    }

}
