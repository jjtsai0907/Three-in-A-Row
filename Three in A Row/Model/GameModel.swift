//
//  GameModel.swift
//  Three in A Row
//
//  Created by Jia-Jiuan Tsai on 2021-01-01.
//

import Foundation
import UIKit

struct GameModel{
    
    var firstPlayerTurn: Bool = true
    
    var firstPlayer = Player(name: "JJJJ")
    var secondPlayer = Player(name: "OOOO")
    
    let fullProgressBar = Float(1.0)

    let secondsTotal = 5.0
    var secondsLeft = 5.0
    
    
    let timerInterval = 0.1
    
    var blocksSymbols: Array<String> = ["a", "b", "c", "d", "e", "f", "g", "h", "i"]
    
    var win: Bool = false
    
    
    // What happens when block is tapped:
    
    // To show who is the currenct player
    mutating func activePlayer () -> String {
        
        if firstPlayerTurn {
            // true: player one
            return "\(secondPlayer.name)'s Turn"
        }else{
            // false: player two
            return "\(firstPlayer.name)'s Turn"
        }
    
        
        
    }
    
    func activePlayerIndex () -> Array<Int>{
        
        if firstPlayerTurn {
            return [0,1]
        }
        else{
            return [1,0]
        }
    }
    
    
    
    
    
    
    mutating func changeSymbol (blockIndex: Int) -> UIImage {
        
        
        
        if firstPlayerTurn {
            let firstPlayerSymbol = #imageLiteral(resourceName: "round2")
            firstPlayerTurn = false
            blocksSymbols[blockIndex] = "O"
            checkIfWins()
            return firstPlayerSymbol
            
        }else{
            let secondPlayerSymbol = #imageLiteral(resourceName: "addmealphoto")
            firstPlayerTurn = true
            blocksSymbols[blockIndex] = "X"
            checkIfWins()
            return secondPlayerSymbol
        }
        
        
    }
    
    mutating func resetTimer (timer: Timer){
        timer.invalidate()
        secondsLeft = secondsTotal
    }
    
    
    mutating func updateSecondsLeft (timer: Timer) {
        
        
        if secondsLeft < 0 {
            timer.invalidate()
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
                
                return
            }
            
            else if winningPosibility[i] == ["O", "O", "O"]{
                print("Winning is OOOOOOO ")
                win=true
                
                return
            }
            else{
                
            }
        }
        
        
    }
    
    
    mutating func restartGame () {
        firstPlayerTurn = true
        secondsLeft = secondsTotal
        blocksSymbols = ["a", "b", "c", "d", "e", "f", "g", "h", "i"]
        
        win = false
    }



}
