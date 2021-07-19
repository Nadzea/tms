//
//  ViewController.swift
//  culculation
//
//  Created by Надежда Клименко on 18.07.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputAndOutput: UITextField!
    
    
    @IBOutlet var myButton: [UIButton]!
    
    
    
    @IBOutlet weak var myNull: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myButton.forEach { button in
            button.layer.cornerRadius = button.frame.height / 2
        }
        myNull.layer.cornerRadius = myNull.frame.height / 2
        
        
        // Do any additional setup after loading the view.
    }


}

