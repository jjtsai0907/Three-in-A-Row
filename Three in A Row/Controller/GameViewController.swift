//
//  ViewController.swift
//  Three in A Row
//
//  Created by Jia-Jiuan Tsai on 2020-12-27.
//

import UIKit


class GameViewController: UIViewController {

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
    
    @IBOutlet weak var firstPlayerScore: UILabel!
    @IBOutlet weak var secondPlayerScore: UILabel!
    
    
    var listOfBlocks: Array<UIImageView> = []
    var listOfLabels: Array<UILabel> = []
    var listOfBars: Array<UIProgressView> = []
    var listOfScoreLabels: Array<UILabel> = []

    var timer = Timer()

    

    var playerOneName: String?
    var playerTwoName: String?
    
    var gameModel = GameModel()
    
    
    /////////////  Active Player's index ==  gameModel.activePlayerIndex()[1]
    ////////////  Inactive Player's index ==  gameModel.activePlayerIndex()[0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional  setup after loading the view.
        

        
        greenPlayer.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        secondPlayerScore.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        
        listOfBlocks = [block0, block1, block2, block3, block4, block5, block6, block7, block8]
        
        listOfLabels = [bluePlayer, greenPlayer]
        listOfBars = [blueProgressBar, greenProgressBar]
        listOfScoreLabels = [firstPlayerScore, secondPlayerScore]
        
        //gameModel.firstPlayer = playerOneName
        print("playerOneName: \(playerOneName)")
        
        gameModel.firstPlayer = Player(name: playerOneName!)
        gameModel.secondPlayer = Player(name: playerTwoName!)
        
    }


    @IBAction func blockTapped(_ sender: UITapGestureRecognizer) {
        
        gameModel.resetTimer(timer: timer)
        listOfBlocks[sender.view?.tag ?? 10].image = gameModel.changeSymbol(blockIndex: sender.view?.tag ?? 10)
        listOfBlocks[sender.view?.tag ?? 10].isUserInteractionEnabled = false
        
        
        if gameModel.win{
            print("WINNNNNNNN")
            showAlert()
            
        }else{
            timer = Timer.scheduledTimer(timeInterval: gameModel.timerInterval, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
            
            // what to do with the inactive player's UI
            listOfLabels[gameModel.activePlayerIndex()[0]].text = gameModel.activePlayer()
            listOfBars[gameModel.activePlayerIndex()[0]].progress = 1
        }
        
        
        
        
    }
    
    
    func showAlert() {
        let alert = UIAlertController(title: "You win!", message: "restart?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { action in
            print("clicked cancel")
            
            // update winner's score
            self.listOfScoreLabels[self.gameModel.activePlayerIndex()[0]].text = "Scores: \(self.gameModel.playerScores[self.gameModel.activePlayerIndex()[0]])"
            
            self.gameModel.restartGame()
            
            for i in 0...8{
                self.listOfBlocks[i].image = nil
                self.listOfBlocks[i].isUserInteractionEnabled = true
                
            }
            self.greenPlayer.text = "Player 2"
            self.bluePlayer.text = "Player 1"
            self.blueProgressBar.progress = self.gameModel.updateProgress()
            self.greenProgressBar.progress = self.gameModel.updateProgress()
            
        }))
        
        present(alert, animated: true)
        
    }
    
    
    
    

    
    @objc func updateTimer(){
        
        
        
        gameModel.updateSecondsLeft(timer: timer)
        
        listOfLabels[gameModel.activePlayerIndex()[1]].text =
            String(Int(ceil(gameModel.secondsLeft)))
        
        listOfBars[gameModel.activePlayerIndex()[1]].progress = gameModel.updateProgress()
            
        
        
        print("timer running \(gameModel.secondsLeft)")
        
        
    }
    
    
        
}

