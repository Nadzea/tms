//
//  ViewController.swift
//  homeworkLesson2
//
//  Created by Надежда Клименко on 16.06.21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //task1
        let number1:                    Float = 5.4
        let number2:                    Float = 3.5
        let number3:                    Float = 8.7
        let number4:                    Float = 2.3
        let sumOfInt:                   Int
        let multiplicationOfInt:        Int
        let sumOfFraction:              Int
        let multiplicationOfFraction:   Int
        
        sumOfInt = Int(number1) + Int(number2) + Int(number3) + Int(number4)
        multiplicationOfInt = Int(number1) * Int(number2) * Int(number3) * Int(number4)
        sumOfFraction = Int(number1 * 10) % 10 + Int(number2 * 10) % 10 + Int(number3 * 10) % 10 + Int(number4 * 10) % 10
        multiplicationOfFraction = (Int(number1 * 10) % 10) * (Int(number2 * 10) % 10) * (Int(number3 * 10) % 10) * (Int(number4 * 10) % 10)
        
        print("Sum of integer = \(sumOfInt)")
        print("Multiplication of integer = \(multiplicationOfInt)")
        print("Sum of fraction = \(sumOfFraction)")
        print("Multiplication of fraction = \(multiplicationOfFraction)")
        
        //task2
        
        let randomInt = Int.random(in: 0..<100 )
        
        if randomInt % 2 == 0 {
            print("\(randomInt) - Even integer ")
        } else {
            print("\(randomInt) - Odd integer")
        }
        
        
        
        // Do any additional setup after loading the view.
    }


}

