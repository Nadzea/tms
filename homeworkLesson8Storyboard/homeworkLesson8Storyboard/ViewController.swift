//
//  ViewController.swift
//  homeworkLesson8Storyboard
//
//  Created by Надежда Клименко on 7.07.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var label2: UILabel!
    
    @IBAction func buttonResult(_ sender: Any) {
        guard textField1.text! != "", textField2.text! != "" else {
            label2.text = "You don't enter numbers"
            return
        }
        let number1 = Int(textField1.text!)
        let number2 = Int(textField2.text!)
        if let noOptNumber1 = number1, let noOptNumber2 = number2 {
                let result = noOptNumber1 + noOptNumber2
                label2.text = "\(result)"
            
            } else {
                label2.text = "ERROR"
                
            }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

