//
//  ViewController.swift
//  homeworkLesson8Cod
//
//  Created by Надежда Клименко on 7.07.21.
//

import UIKit

class ViewController: UIViewController{
    let textFieldNumber1 = UITextField()
    let textFieldNumber2 = UITextField()
    let label2 = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 100 / 255, green: 200 / 255, blue: 180 / 255, alpha: 1.0)
        
        textFieldNumber1.frame = CGRect(x: 100,
                                        y: 180,
                                        width: 200,
                                        height: 50)
        textFieldNumber1.backgroundColor = .white
        textFieldNumber1.placeholder = "Enter the first number"
        view.addSubview(textFieldNumber1)
        
        textFieldNumber2.frame = CGRect(x: 100,
                                        y: 280,
                                        width: 200,
                                        height: 50)
        textFieldNumber2.backgroundColor = .white
        textFieldNumber2.placeholder = "Enter the second number"
        view.addSubview(textFieldNumber2)
        
        let label1 = UILabel(frame: CGRect(x: 190,
                                           y: 245,
                                           width: 20,
                                           height: 20))
        label1.textColor = .black
        label1.text = "+"
        view.addSubview(label1)
        
        let buttonResult = UIButton(frame: CGRect(x: 185,
                                                  y: 340,
                                                  width: 20,
                                                  height: 20))
        buttonResult.setTitle("=", for: .normal)
        buttonResult.setTitleColor(.black, for: .normal)
        buttonResult.addTarget(self, action: #selector(buttonResultTapped(_:)), for: UIControl.Event.touchUpInside)
        view.addSubview(buttonResult)
     
        label2.frame = CGRect(x: 100,
                              y: 380,
                              width: 200,
                              height: 20)
        label2.textColor = .black
        label2.textAlignment = .center
        view.addSubview(label2)
        
        
//        let buttonTask2 = UIButton(frame: CGRect(x: 160, y: 540, width: 80, height: 20))
//        buttonTask2.setTitle("Task2", for: .normal)
//        buttonTask2.setTitleColor(.black, for: .normal)
//        buttonTask2.addTarget(self, action: #selector(buttonTask2Tapped(_:)), for: UIControl.Event.touchUpInside)
//        view.addSubview(buttonTask2)
        
    }
    @objc
    func buttonResultTapped(_ sender: UIButton){
        guard textFieldNumber1.text! != "", textFieldNumber2.text! != "" else {
            label2.text = "You don't enter numbers"
            return
        }
        let number1 = Int(textFieldNumber1.text!)
        let number2 = Int(textFieldNumber2.text!)
        //var result: Int = 0
        if let noOptNumber1 = number1, let noOptNumber2 = number2 {
                let result = noOptNumber1 + noOptNumber2
                label2.text = "\(result)"
            
            } else {
                label2.text = "ERROR"
                
            }
    }
//    @objc
//    func buttonTask2Tapped(_ sender: UIButton){
//        print("Button was tapped")
//        present(task2ViewController, animated: true)
//
//    }
    

}



