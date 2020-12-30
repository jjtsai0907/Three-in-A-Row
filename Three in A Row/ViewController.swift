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
    
    var whosturn: Bool = false
    
    let totalSeconds: Float = 5
    var turnSeconds: Float = 5
    
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional  setup after loading the view.
        
        greenPlayer.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        listOfBlocks = [block0, block1, block2, block3, block4, block5, block6, block7, block8]
    }


    @IBAction func blockTapped(_ sender: UITapGestureRecognizer) {
        
        timer.invalidate()
        turnSeconds = 5
        print("ff")
        print(sender.view?.tag ?? 10)
        
        changePhoto(tagNumber: sender.view?.tag ?? 10)
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    func changePhoto (tagNumber: Int){
        
        if whosturn {
        
            listOfBlocks[tagNumber].image = #imageLiteral(resourceName: "addmealphoto")
            listOfBlocks[tagNumber].isUserInteractionEnabled = false
            whosturn = false
        }
        else{
            listOfBlocks[tagNumber].image = #imageLiteral(resourceName: "round2")
            listOfBlocks[tagNumber].isUserInteractionEnabled = false
            whosturn = true
        }
        
        
        
    }
    
    
    @objc func updateTimer(){
        if turnSeconds < 0 {
            timer.invalidate()
            
        }
        
        if whosturn {
            // round blue
            bluePlayer.text = String(Int(ceil(turnSeconds)))
            greenPlayer.text = "Blue's Turn"
            greenProgressBar.progress = 1.0
            let progressPercentage = Float(turnSeconds) / Float(totalSeconds)
            
            blueProgressBar.progress = progressPercentage
            
            
        }else{
            // food green
            greenPlayer.text = String(Int(ceil(turnSeconds)))
            bluePlayer.text = "Green's Turn"
            blueProgressBar.progress = 1.0
            let progressPercentage = Float(turnSeconds) / Float(totalSeconds)
            
            greenProgressBar.progress = progressPercentage
        }
        
        print("timer running \(turnSeconds)")
        
        turnSeconds -= 0.1
        
    }
        
}

