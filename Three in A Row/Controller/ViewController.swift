//
//  ViewController.swift
//  Three in A Row
//
//  Created by Jia-Jiuan Tsai on 2020-12-27.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var block0: UIImageView!
    @IBOutlet weak var block1: UIImageView!
    @IBOutlet weak var block2: UIImageView!
    @IBOutlet weak var block3: UIImageView!
    @IBOutlet weak var block4: UIImageView!
    @IBOutlet weak var block5: UIImageView!
    @IBOutlet weak var block6: UIImageView!
    @IBOutlet weak var block7: UIImageView!
    @IBOutlet weak var block8: UIImageView!
    
    @IBOutlet weak var bluePlayer: UILabel!
    @IBOutlet weak var greenPlayer: UILabel!
    @IBOutlet weak var blueProgressBar: UIProgressView!
    @IBOutlet weak var greenProgressBar: UIProgressView!
    
    var listOfBlocks: Array<UIImageView> = []
    var listOfLabels: Array<UILabel> = []
    var listOfBars: Array<UIProgressView> = []

    var timer = Timer()

    var gameModel = GameModel()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional  setup after loading the view.
        

        
        greenPlayer.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        listOfBlocks = [block0, block1, block2, block3, block4, block5, block6, block7, block8]
        
        listOfLabels = [bluePlayer, greenPlayer]
        listOfBars = [blueProgressBar, greenProgressBar]
    }


    @IBAction func blockTapped(_ sender: UITapGestureRecognizer) {
        
        gameModel.resetTimer(timer: timer)
        listOfBlocks[sender.view?.tag ?? 10].image = gameModel.changeSymbol()
        listOfBlocks[sender.view?.tag ?? 10].isUserInteractionEnabled = false
        
        
        timer = Timer.scheduledTimer(timeInterval: gameModel.timerInterval, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        listOfLabels[gameModel.activePlayerIndex()[0]].text = gameModel.activePlayer()
        
        listOfBars[gameModel.activePlayerIndex()[0]].progress = 1
        
    }
    
    
    
    
    

    
    @objc func updateTimer(){
        
        
        
        gameModel.updateSecondsLeft(timer: timer)
        
        listOfLabels[gameModel.activePlayerIndex()[1]].text =
            String(Int(ceil(gameModel.secondsLeft)))
        
        listOfBars[gameModel.activePlayerIndex()[1]].progress = gameModel.updateProgress()
            
        
        
        print("timer running \(gameModel.secondsLeft)")
        
        
    }
        
}

