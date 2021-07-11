//
//  ViewController.swift
//  homeworkLesson9HandIn
//
//  Created by Надежда Клименко on 12.07.21.
//

import UIKit
protocol ViewControllerDelegate: class { //через протокол передаем данные со второго экрана на первый
    func ageAndGender(age: String, gender: String ) //объявляем функцию через которую будем передавать данные
}

class ViewController: UIViewController, ViewControllerDelegate {
    
    @IBOutlet weak var errorName: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func enterButton(_ sender: Any) {
        guard !nameTextField.text!.isEmpty else { //делаем проверку введено ли имя
            errorName.text = "You do not enter name"
            errorName.textColor = .red
            return
        }
        let storyboard2 = UIStoryboard(name: "ViewController2", bundle: nil)
        if let view2 = storyboard2.instantiateInitialViewController() as? ViewController2 {
            view2.name = nameTextField.text! //переменная name объявлена в ViewController2, так как введенное имя выводим на втрой экран
            view2.delegate = self
            view2.modalTransitionStyle = .flipHorizontal //эффект появления второго экрана
            view2.modalPresentationStyle = .fullScreen //второй экран разворачивается на весь экран
            present(view2, animated: true, completion: nil)
        }
    }

    func ageAndGender(age: String, gender: String) {
        let humanAge = Int(age)!
        if humanAge > 50, (gender == "M" || gender == "m") {
            view.backgroundColor = .red
        } else {
            if (gender == "F" || gender == "f") {
                view.backgroundColor = .yellow
            } else {
                view.backgroundColor = .green
            }
        }
        
    }
    

}

