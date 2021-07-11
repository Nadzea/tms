//
//  ViewController2.swift
//  homeworkLesson9HandIn
//
//  Created by Надежда Клименко on 12.07.21.
//

import UIKit

class ViewController2: UIViewController, UITextFieldDelegate {
    var name: String = "" //переменная в которую будет забираться имя с первого экрана

    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var errorAgeOrGender: UILabel!
    
    weak var delegate: ViewControllerDelegate? // объявляем "посредника", через которого будем передавать данные на первый экран
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageTextField.delegate = self //объявляем, что данные этих переменных будут передаваться с помощью "посредника" delegate
        genderTextField.delegate = self
        helloLabel.text = "Hello, \(name)! Enter your data: age and gender"
    }
    
    @IBAction func closeButton(_ sender: Any) {
        guard !ageTextField.text!.isEmpty, !genderTextField.text!.isEmpty else {
            errorAgeOrGender.text = "*You do not enter your age or gender"
            errorAgeOrGender.textColor = .red
            return
        }
        delegate?.ageAndGender(age: ageTextField.text!, gender: genderTextField.text!) //вызываем функцию протокола, чтобы забрать данные с текстфилдов
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == ageTextField {
            genderTextField.becomeFirstResponder()
        } else {
            genderTextField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        guard !string.isEmpty else {return true}
        
        if textField == ageTextField {
            if (textField.text?.count ?? 0) + string.count < 3 {
                switch string {
                case "0"..."9":
                    return true
                default:
                    return false
                }
            }
        }
        
        if textField == genderTextField {
            if (textField.text?.count ?? 0) + string.count < 2 {
                switch string {
                case "F", "f", "M", "m":
                    return true
                default:
                    return false
                }
            }
        }
        return false
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
