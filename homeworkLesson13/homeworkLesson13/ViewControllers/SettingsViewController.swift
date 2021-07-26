//
//  SettingsViewController.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 24.07.21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var backSettingsScreen: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGradient(with: #colorLiteral(red: 0.3084577813, green: 0.8235294223, blue: 0.6689409236, alpha: 1), color2: #colorLiteral(red: 0.8111680768, green: 0.6732622305, blue: 0.9686274529, alpha: 1))
        
        backSettingsScreen.addShadow(with: .black, opacity: 0.5, shadowOffset: CGSize(width: 10, height: 10))

    }
    
    @IBAction func backSettingsScreen(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}