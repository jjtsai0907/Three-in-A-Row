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
    
    var listOfBlocks: Array<UIImageView> = []
    
    var whosturn: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional  setup after loading the view.
        
        listOfBlocks = [block0, block1, block2, block3, block4, block5, block6, block7, block8]
    }


    @IBAction func blockTapped(_ sender: UITapGestureRecognizer) {
        
        print("ff")
        print(sender.view?.tag ?? 10)
        
        changePhoto(tagNumber: sender.view?.tag ?? 10)
        
        
        //position0.image = #imageLiteral(resourceName: "addmealphoto")
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
}

