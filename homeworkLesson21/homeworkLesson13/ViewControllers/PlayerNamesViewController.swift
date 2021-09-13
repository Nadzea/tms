//
//  PlayerNamesViewController.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 25.08.21.
//

import UIKit

class PlayerNamesViewController: UIViewController {
    
    @IBOutlet weak var player1: UITextField!
    @IBOutlet weak var player2: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func getViewController(with storyboard: String) -> UIViewController {
        let currentStoryboard = UIStoryboard(name: storyboard, bundle: nil)
        let currentViewController = currentStoryboard.instantiateInitialViewController()
        currentViewController?.modalPresentationStyle = .fullScreen
        currentViewController?.modalTransitionStyle = .flipHorizontal
        return currentViewController!
    }
    
    @IBAction func submitButton() {
        guard !player1.text!.isEmpty, !player2.text!.isEmpty else {
            errorLabel.text = "You don't enter the names of players"
            errorLabel.textColor = .red
            return
        }
        SaveData.savedNameOfPlayer(nameOfPlayer1: player1.text!, nameOfPlayer2: player2.text!)
        
        present(getViewController(with: "PlayViewController"), animated: true)
        
//        dismiss(animated: true) {
//            
//        }
        
    }
    
    @IBAction func cancelButton() {
        dismiss(animated: true, completion: nil)
    }

}
