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
    
    @IBOutlet weak var playerOne: UILabel!
    @IBOutlet weak var playerTwo: UILabel!
    @IBOutlet weak var playerOneProgressBar: UIProgressView!
    @IBOutlet weak var playerTwoProgressBar: UIProgressView!
    
    @IBOutlet weak var playerOneScore: UILabel!
    @IBOutlet weak var playerTwoScore: UILabel!
    
    
    var listOfBlocks: Array<UIImageView> = []
    var listOfLabels: Array<UILabel> = []
    var listOfBars: Array<UIProgressView> = []
    var listOfScoreLabels: Array<UILabel> = []

    var timer = Timer()
    var aiTimer = Timer()

    
    @IBOutlet weak var tableStack: UIStackView!
    
    var playerOneName: String?
    var playerTwoName: String?
    
    var gameModel = GameModel()
    
    var gameVCPlayAgainstAI: Bool = false
    /////////////  Active Player's index ==  gameModel.activePlayerIndex()[1]
    ////////////  Inactive Player's index ==  gameModel.activePlayerIndex()[0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional  setup after loading the view.
        

        
        playerTwo.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        playerTwoScore.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        
        listOfBlocks = [block0, block1, block2, block3, block4, block5, block6, block7, block8]
        
        listOfLabels = [playerOne, playerTwo]
        listOfBars = [playerOneProgressBar, playerTwoProgressBar]
        listOfScoreLabels = [playerOneScore, playerTwoScore]
        
        //gameModel.firstPlayer = playerOneName
        print("playerOneName: \(playerOneName!)")
        print("against AI: \(gameVCPlayAgainstAI)")
        
        gameModel.ifAgainstAI = gameVCPlayAgainstAI
        
        gameModel.firstPlayer = Player(name: playerOneName!)
        gameModel.secondPlayer = Player(name: playerTwoName!)
        
        playerTwo.text = playerTwoName
        playerOne.text = "\(playerOneName!) Starts"
        
    }


    @IBAction func blockTapped(_ sender: UITapGestureRecognizer) {
        
        
        print(gameModel.countTimes)
        
        updateSymbol(blockIndex: sender.view?.tag ?? 10)
        
        
        
        if gameVCPlayAgainstAI {
            
            tableStack.isUserInteractionEnabled = false
            
            if gameModel.win || gameModel.even {
            //Do nothing
            }else{
                aiTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { [self] (Timer) in
                    updateSymbol(blockIndex: gameModel.randomBlock())
                    tableStack.isUserInteractionEnabled = true
                    })
            }
                

            
            //updateSymbol(blockIndex: gameModel.randomBlock())
    
        }
        
        
        
        
    }
    
    
    func showAlert() {
        let alert = UIAlertController(title: gameModel.alertTitle, message: "restart?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { action in
            print("clicked cancel")
            
            // update winner's score
            self.listOfScoreLabels[self.gameModel.activePlayerIndex()[0]].text = "Scores: \(self.gameModel.playerScores[self.gameModel.activePlayerIndex()[0]])"
            
            self.gameModel.restartGame()
            self.tableStack.isUserInteractionEnabled = true
            
            for i in 0...8{
                self.listOfBlocks[i].image = nil
                self.listOfBlocks[i].isUserInteractionEnabled = true
                
            }
            self.playerTwo.text = self.playerTwoName
            self.playerOne.text = "\(self.playerOneName!) Starts"
            self.playerOneProgressBar.progress = self.gameModel.updateProgress()
            self.playerTwoProgressBar.progress = self.gameModel.updateProgress()
            
        }))
        
        present(alert, animated: true)
        
    }
    
    
    
    

    
    @objc func updateTimer(){
        
        
        
        gameModel.updateSecondsLeft(timer: timer)
        
        listOfLabels[gameModel.activePlayerIndex()[1]].text =
            String(Int(ceil(gameModel.secondsLeft)))
        
        listOfBars[gameModel.activePlayerIndex()[1]].progress = gameModel.updateProgress()
            
        
        
        //print("timer running \(gameModel.secondsLeft)")
        
        
        
    }
    
    func updateSymbol (blockIndex: Int) {
        gameModel.resetTimer(timer: timer)
        listOfBlocks[blockIndex].image = gameModel.changeSymbol(blockIndex: blockIndex)
        listOfBlocks[blockIndex].isUserInteractionEnabled = false
        
        self.listOfScoreLabels[self.gameModel.activePlayerIndex()[0]].text = "Scores: \(self.gameModel.playerScores[self.gameModel.activePlayerIndex()[0]])"
        
        
        if gameModel.win || gameModel.even {
            
            aiTimer.invalidate()
            

            
            print("WINNNNNNNN or Even")
            showAlert()
            
        }else{
            timer = Timer.scheduledTimer(timeInterval: gameModel.timerInterval, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
            
            // what to do with the inactive player's UI
            listOfLabels[gameModel.activePlayerIndex()[0]].text = gameModel.activePlayer()
            listOfBars[gameModel.activePlayerIndex()[0]].progress = 1
        }

    
    }
    
    
        
}

