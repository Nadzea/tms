//
//  AboutChessViewController.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 31.07.21.
//

import UIKit

class AboutChessViewController: UIViewController {
    
    @IBOutlet weak var mainViewButton: UIView!
    @IBOutlet weak var imageViewButton: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGradient(with: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
        
        mainViewButton.addGradient(with: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.7087161869, green: 0.993346738, blue: 1, alpha: 1))
        mainViewButton.layer.cornerRadius = 20
        imageViewButton.layer.cornerRadius = 15
        
    }
    @IBAction func backAboutScreen(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
