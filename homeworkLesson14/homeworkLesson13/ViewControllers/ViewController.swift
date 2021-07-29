//
//  ViewController.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 24.07.21.
//

import UIKit

class ViewController: UIViewController {
    let storyboards: [String] = ["PlayViewController", "ResultsViewController", "SettingsViewController"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGradient(with: #colorLiteral(red: 0.5910794118, green: 0.8861165633, blue: 0.9093515455, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
        
    }
    
    func getViewController(with storyboard: String) -> UIViewController {
        let currentStoryboard = UIStoryboard(name: storyboard, bundle: nil)
        let currentViewController = currentStoryboard.instantiateInitialViewController()
        currentViewController?.modalPresentationStyle = .fullScreen
        currentViewController?.modalTransitionStyle = .flipHorizontal
        return currentViewController!
    }
    
    @IBAction func goToNewScreen(_ sender: UIButton) {
        present(getViewController(with: storyboards[sender.tag]), animated: true, completion: nil)
    }
    
}

