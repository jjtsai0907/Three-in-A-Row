//
//  EntryViewController.swift
//  Three in A Row
//
//  Created by Jia-Jiuan Tsai on 2021-01-02.
//

import UIKit

class EntryViewController: UIViewController{
    @IBOutlet weak var twoPlayerButton: UIButton!
    @IBOutlet weak var againstAIButton: UIButton!
    
    @IBOutlet weak var playerOneInput: UITextField!
    
    @IBOutlet weak var playerTwoInput: UITextField!
    
    @IBOutlet weak var backToMenuButton: UIButton!
    
    @IBOutlet weak var startGameButton: UIButton!
    
    var entryVCPlayAgainstAI : Bool = false
    
    //let gameModel2 = GameModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerOneInput.alpha = 0.0
        playerTwoInput.alpha = 0.0
        backToMenuButton.alpha = 0.0
        startGameButton.alpha = 0.0
    }
    
    
    @IBAction func twoPlayersPressed(_ sender: UIButton) {
        
        twoPlayerButton.alpha = 0.0
        againstAIButton.alpha = 0.0
        playerOneInput.alpha = 1.0
        playerTwoInput.alpha = 1.0
        backToMenuButton.alpha = 1.0
        startGameButton.alpha = 1.0
        print("fff")
        
        //self.performSegue(withIdentifier: "goToGame", sender: self)
    }
    
    @IBAction func startGamePressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToGame", sender: self)
            
        //playerOneInput.text
            
    }
    
    
    @IBAction func playAgainstAIPressed(_ sender: UIButton) {
        twoPlayerButton.alpha = 0.0
        againstAIButton.alpha = 0.0
        playerOneInput.alpha = 1.0
        backToMenuButton.alpha = 1.0
        startGameButton.alpha = 1.0
        
        entryVCPlayAgainstAI = true
        
        playerTwoInput.text = "AI Butt"
        
    }
    
    
    
    
    @IBAction func backToMenuPressed(_ sender: UIButton) {
        twoPlayerButton.alpha = 1.0
        againstAIButton.alpha = 1.0
        playerOneInput.alpha = 0.0
        playerTwoInput.alpha = 0.0
        backToMenuButton.alpha = 0.0
        startGameButton.alpha = 0.0
        entryVCPlayAgainstAI = false
        playerTwoInput.text = ""
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame" {
            let destinationVC = segue.destination as! GameViewController
            destinationVC.playerOneName = playerOneInput.text
            destinationVC.playerTwoName = playerTwoInput.text
            destinationVC.gameVCPlayAgainstAI = entryVCPlayAgainstAI
            
        }
        
        
    }
    
    
}
