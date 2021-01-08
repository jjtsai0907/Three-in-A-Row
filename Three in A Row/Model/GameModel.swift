//
//  GameModel.swift
//  Three in A Row
//
//  Created by Jia-Jiuan Tsai on 2021-01-01.
//

import Foundation
import UIKit

struct GameModel{
    
    var countTimes: Int = 0
    
    var ifAgainstAI: Bool = false
    
    var firstPlayerTurn: Bool = true
    
    
    var firstPlayer = Player(name : "")
    var secondPlayer = Player(name : "AI")
    
    
    let fullProgressBar = Float(1.0)

    let secondsTotal = 5.0
    var secondsLeft = 5.0
    
    
    let timerInterval = 0.1
    
    var blocksSymbols: Array<String> = ["a", "a", "a", "a", "a", "a", "a", "a", "a"]
    
    var win: Bool = false
    var even: Bool = false
    
    var randNr: Int = 0
    
    var playerScores = [0, 0]

    var alertTitle: String?
    
    
    
    // What happens when block is tapped:
    
    // To show who is the currenct player
    mutating func activePlayer () -> String {
        
        
        if firstPlayerTurn {
            // true: player one
            return "\(firstPlayer.name)'s Turn"
        }else{
            // false: player two
            return "\(secondPlayer.name)'s Turn"
        }
    
        
        
    }
    
    
    

    
    
    func activePlayerIndex () -> Array<Int>{
        
        if firstPlayerTurn {
            return [1,0]
        }
        else{
            return [0,1]
        }
    }
    
    
    
    
    
    
    mutating func changeSymbol (blockIndex: Int) -> UIImage {
        
        countTimes += 1
        checkIfEven()
        
        if firstPlayerTurn {
            let firstPlayerSymbol = #imageLiteral(resourceName: "thunder_sym")
            firstPlayerTurn = false
            blocksSymbols[blockIndex] = "O"
            checkIfWins()
            
            return firstPlayerSymbol
            
        }else{
            if ifAgainstAI {
                let secondPlayerSymbol = #imageLiteral(resourceName: "monkey_wrench")
                firstPlayerTurn = true
                blocksSymbols[blockIndex] = "X"
                checkIfWins()
                return secondPlayerSymbol
                
            }else{
                let secondPlayerSymbol = #imageLiteral(resourceName: "tenki_mark03_gouu")
                firstPlayerTurn = true
                blocksSymbols[blockIndex] = "X"
                checkIfWins()
                return secondPlayerSymbol
                
            }
            
        }
        
        
    }
    
    mutating func resetTimer (timer: Timer){
        timer.invalidate()
        secondsLeft = secondsTotal
        
        
    }
    
    
    mutating func updateSecondsLeft (timer: Timer) {
        
        
        if secondsLeft < 0 {
            timer.invalidate()
            if firstPlayerTurn {
                playerScores[0] -= 1
                
            }else{
                playerScores[1] -= 1
                
            }
        }
        else{
            secondsLeft -= timerInterval
        }
        
    }
    
    func updateProgress () -> Float {
        let progressPercentage = Float(secondsLeft) / Float(secondsTotal)
        return progressPercentage
    }
    
    
    
    
    
    mutating func checkIfWins (){
        
        let winningPosibility: Array<Array<String>> = [
            [blocksSymbols[0], blocksSymbols[1], blocksSymbols[2]],
            [blocksSymbols[3], blocksSymbols[4], blocksSymbols[5]],
            [blocksSymbols[6], blocksSymbols[7], blocksSymbols[8]],
            [blocksSymbols[0], blocksSymbols[3], blocksSymbols[6]],
            [blocksSymbols[1], blocksSymbols[4], blocksSymbols[7]],
            [blocksSymbols[2], blocksSymbols[5], blocksSymbols[8]],
            [blocksSymbols[0], blocksSymbols[4], blocksSymbols[8]],
            [blocksSymbols[2], blocksSymbols[4], blocksSymbols[6]]]
        
        for i in 0...7 {
            if winningPosibility[i] == ["X", "X", "X"] {
                print("Winning is XXXXXX ")
                win=true
                playerScores[1] += 1
                alertTitle = "\(secondPlayer.name) Wins!"
                return
            }
            
            else if winningPosibility[i] == ["O", "O", "O"]{
                print("Winning is OOOOOOO ")
                win=true
                playerScores[0] += 1
                alertTitle = "\(firstPlayer.name) Wins!"
                return
            }
            else{
                
            }
        }
        
        
    }
    
    
    mutating func restartGame () {
        firstPlayerTurn = true
        secondsLeft = secondsTotal
        blocksSymbols = ["a", "a", "a", "a", "a", "a", "a", "a", "a"]
        countTimes = 0
        win = false
        even = false
    }
    
    mutating func randomBlock() -> Int {
        
        randNr = Int.random(in: 0...8)
        
        while blocksSymbols[randNr] != "a" {
            randNr = Int.random(in: 0...8)
        }
        
        print(blocksSymbols[randNr])
        return randNr
        
    }
    
    mutating func checkIfEven () {
        
        if win == false && countTimes == 9 {
            print("even!!! ")
            alertTitle = "No One Wins"
            even = true
        }
        
    }
    
    func entryVCCharacter (againstAI: Bool) -> UIImage {
        
        if againstAI {
            let robotImage = #imageLiteral(resourceName: "robot")
            
            return robotImage
        }else{
            let waterCha = #imageLiteral(resourceName: "water_character")
            return waterCha
        }
        
    }


}
