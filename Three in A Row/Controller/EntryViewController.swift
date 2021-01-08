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
    @IBOutlet weak var player2Image: UIImageView!
    
    var entryVCPlayAgainstAI : Bool = false
    
    let gameModel2 = GameModel()
    
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
        player2Image.image = gameModel2.entryVCCharacter (againstAI: entryVCPlayAgainstAI)
    }
    
    @IBAction func startGamePressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToGame", sender: self)
            
    }
    
    
    @IBAction func playAgainstAIPressed(_ sender: UIButton) {
        twoPlayerButton.alpha = 0.0
        againstAIButton.alpha = 0.0
        playerOneInput.alpha = 1.0
        backToMenuButton.alpha = 1.0
        startGameButton.alpha = 1.0
        entryVCPlayAgainstAI = true
        player2Image.image = gameModel2.entryVCCharacter (againstAI: entryVCPlayAgainstAI)
        playerTwoInput.text = "Sexy AI"
        
    }
    
    
    
    
    @IBAction func backToMenuPressed(_ sender: UIButton) {
        resetSetting ()
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame" {
            let destinationVC = segue.destination as! GameViewController
            destinationVC.playerOneName = playerOneInput.text
            destinationVC.playerTwoName = playerTwoInput.text
            destinationVC.gameVCPlayAgainstAI = entryVCPlayAgainstAI
            
        }
        
        
    }
    
    func resetSetting () {
        twoPlayerButton.alpha = 1.0
        againstAIButton.alpha = 1.0
        playerOneInput.alpha = 0.0
        playerTwoInput.alpha = 0.0
        backToMenuButton.alpha = 0.0
        startGameButton.alpha = 0.0
        entryVCPlayAgainstAI = false
        playerTwoInput.text = ""
        player2Image.image = #imageLiteral(resourceName: "entry_shadow")
    }
    
    
}
