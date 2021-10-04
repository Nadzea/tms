//
//  ViewController.swift
//  Weather
//
//  Created by Надежда Клименко on 5.09.21.
//

import UIKit

class EnterTheCityViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: .main) { _ in
            if self.textField.text != "" {
                self.errorLabel.text = ""
            }
        }
    }
    
    func presentWeatherInfoScreen() {
        guard let cityName = textField.text, !cityName.isEmpty else {
            errorLabel.text = "You haven't entered the city"
            return
        }
        let storyboard = UIStoryboard(name: "WeatherInfoViewController", bundle: nil)
        
        guard let vc = storyboard.instantiateInitialViewController() as? WeatherInfoViewController else {
            return
        }
        
        vc.city = cityName
        
        textField.text = ""
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.first) != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    } //чтобы клавиатура скрывалась, еси пользователь нажимает зп пределами текстфилда
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        presentWeatherInfoScreen()
        
        textField.resignFirstResponder()
            
        return true
    }
    
    @IBAction func presentWeatherScreen(_ sender: Any) {
        presentWeatherInfoScreen()
    }
    
}

