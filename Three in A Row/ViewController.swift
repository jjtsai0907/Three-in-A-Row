//
//  ViewController.swift
//  Three in A Row
//
//  Created by Jia-Jiuan Tsai on 2020-12-27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var position0: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func position0Tapped(_ sender: UITapGestureRecognizer) {
        
        position0.image = #imageLiteral(resourceName: "addmealphoto")
    }
}

