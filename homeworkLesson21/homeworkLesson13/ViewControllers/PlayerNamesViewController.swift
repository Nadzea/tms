//
//  PlayerNamesViewController.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 25.08.21.
//

import UIKit

class PlayerNamesViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var player1: UITextField!
    @IBOutlet weak var player2: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var helloLabel: UILabel!
    
    var viewControllerDidDismiss: (() -> ())?
    
    deinit {
        viewControllerDidDismiss = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player1.delegate = self
        player2.delegate = self
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: player1, queue: .main) { _ in
            if self.player1.text != "" {
                self.errorLabel.text = ""
            }
        }
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: player2, queue: .main) { _ in
            if self.player2.text != "" {
                self.errorLabel.text = ""
            }
        }
        localized()
        
    }
    
    func localized() {
        player1.placeholder = "player1_placeholder_text".localized
        player2.placeholder = "player2_placeholder_text".localized
        submitButton.setTitle("submit_button_text".localized, for: .normal)
        cancelButton.setTitle("cancel_button_text".localized, for: .normal)
        helloLabel.text = "helloLabel_text".localized
    }
    
    @IBAction func submitButtonAction() {
        guard !player1.text!.isEmpty, !player2.text!.isEmpty else {
            errorLabel.text = "error_label_text".localized
            errorLabel.textColor = .red
            return
        }
        SaveData.savedNameOfPlayer(nameOfPlayer1: player1.text!, nameOfPlayer2: player2.text!)
        
        dismiss(animated: true) {
            self.viewControllerDidDismiss?()
        }
    }
    
    @IBAction func cancelButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.first) != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    } //чтобы клавиатура скрывалась, еси пользователь нажимает зп пределами текстфилда
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == player1 {
            textField.resignFirstResponder()
            player2.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

}
