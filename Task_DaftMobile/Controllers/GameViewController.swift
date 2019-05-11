//
//  FirstViewController.swift
//  Task_DaftMobile
//
//  Created by Nikita Gura on 5/6/19.
//  Copyright © 2019 Nikita Gura. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    //Mark: Variables
    private lazy var labelTimerPrepare = UILabel()
    private lazy var labelTimerGame = UILabel()
    private lazy var labelScore = UILabel()
    
    private var timer: Timer?
    private var secondPrepare = 3
    private var score: Int16 = 0
    private let secondGame = 5
    private var dateGameStarted: NSDate?
    
    private let oneTapGestureRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(labelTimerPrepare)
        view.addSubview(labelTimerGame)
        view.addSubview(labelScore)
        setupLayout()
        setupTimer()
        setupOneTapGestureRecognizer()
        setupObserverdidEnterBackground()
    }
    
    override func loadView() {
        setupView()
        setupLabelTimer()
        setupLabelTimerGame()
        setupLabelScore()
    }
    
    //MARK: Methods
    private func setupView(){
        view = UIView()
        view.backgroundColor = .white
    }
    
    private func setupLabelTimer(){
        labelTimerPrepare.font = UIFont.boldSystemFont(ofSize: 25)
        labelTimerPrepare.textAlignment = .center
        labelTimerPrepare.text = "3"
    }
    
    private func setupLabelTimerGame(){
        labelTimerGame.font = UIFont.boldSystemFont(ofSize: 20)
        labelTimerGame.textAlignment = .center
    }
    
    private func setupLabelScore(){
        labelScore.font = UIFont.boldSystemFont(ofSize: 20)
        labelScore.textAlignment = .center
        labelScore.text = "Score \(score)"
    }
    private func setupLayout(){
        labelTimerPrepare.translatesAutoresizingMaskIntoConstraints = false
        labelTimerGame.translatesAutoresizingMaskIntoConstraints = false
        labelScore.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelTimerPrepare.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            labelTimerPrepare.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            labelScore.topAnchor.constraint(equalTo: labelTimerPrepare.bottomAnchor, constant: 30),
            labelScore.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            labelTimerGame.topAnchor.constraint(equalTo: labelScore.bottomAnchor, constant: 30),
            labelTimerGame.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    private func setupTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    private func setupObserverdidEnterBackground(){
        NotificationCenter.default.addObserver(self, selector: #selector(myObserverMethod), name:UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    private func setupOneTapGestureRecognizer(){
        oneTapGestureRecognizer.addTarget(self, action: #selector(plusScore))
        oneTapGestureRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(oneTapGestureRecognizer)
    }
    
    private func saveResultGame(){
        let game = Game(context: PersistenceSerivce.shared.context)
        game.score = score
        game.gameDate = dateGameStarted
        PersistenceSerivce.shared.saveContext()
        dateGameStarted = nil
    }
    
    
    //MARK: Selectors
    @objc func myObserverMethod() {
        if timer != nil {
            timer?.invalidate()
            let alert = UIAlertController(title: "Game paused", message: "Continue?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func plusScore(){
        if (secondPrepare < 1) {
            score += 1
            labelScore.text = "Score: \(score)"
        }
    }
    
    @objc func update() {
        secondPrepare -= 1;
        labelTimerPrepare.text = "\(secondPrepare)"
        if (secondPrepare < 1) {
            if (dateGameStarted == nil){ dateGameStarted = NSDate()}
            labelTimerPrepare.text = "PLAY"
            let finalSecond = secondPrepare+secondGame
            labelTimerGame.text = "\(finalSecond)"
            
            if(finalSecond < 1){
                timer?.invalidate()
                timer = nil
                oneTapGestureRecognizer.isEnabled = false
                labelTimerGame.text = "0"
                labelTimerPrepare.text = "Game over"
                let alert = UIAlertController(title: "Game over", message: "Your score \(score) \n Do you want play again?", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                    self.oneTapGestureRecognizer.isEnabled = true
                    self.saveResultGame()
                    self.labelTimerPrepare.text = "3"
                    self.labelScore.text = "Score 0"
                    self.score = 0
                    self.secondPrepare = 3
                    self.labelTimerGame.text = ""
                    self.setupTimer()
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {  action in
                    self.saveResultGame()
                    self.dismiss(animated: true, completion: nil)
                }))
                present(alert, animated: true, completion: nil)
            }
        }
        
    }
}
