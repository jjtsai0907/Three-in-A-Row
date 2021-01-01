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

    //let alert = UIAlertController(title: "Did you bring your towel?", message: "It's recommended you bring your towel before continuing.", preferredStyle: .alert)
    //alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
    //alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
    
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
        listOfBlocks[sender.view?.tag ?? 10].image = gameModel.changeSymbol(blockIndex: sender.view?.tag ?? 10)
        listOfBlocks[sender.view?.tag ?? 10].isUserInteractionEnabled = false
        
        if gameModel.win{
            print("WINNNNNNNN")
            showAlert()
            //self.present(alert, animated: true)
            
        }else{
            timer = Timer.scheduledTimer(timeInterval: gameModel.timerInterval, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
            
            listOfLabels[gameModel.activePlayerIndex()[0]].text = gameModel.activePlayer()
            
            listOfBars[gameModel.activePlayerIndex()[0]].progress = 1
        }
        
        
        
        
    }
    
    
    func showAlert() {
        let alert = UIAlertController(title: "You win!", message: "restart?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { action in
            print("clicked cancel")
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

