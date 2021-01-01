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
    
    
    
    
    
    
    mutating func changeSymbol () -> UIImage {
        
        if firstPlayerTurn {
            let firstPlayerSymbol = #imageLiteral(resourceName: "round2")
            firstPlayerTurn = false
            return firstPlayerSymbol
        }else{
            let secondPlayerSymbol = #imageLiteral(resourceName: "addmealphoto")
            firstPlayerTurn = true
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
    
    
    
    




}
