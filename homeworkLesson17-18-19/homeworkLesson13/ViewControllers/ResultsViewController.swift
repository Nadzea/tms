//
//  ResultsViewController.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 24.07.21.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var backResultsScreen: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGradient(with: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        
        backResultsScreen.delegate = self
        
    }
    
}
extension ResultsViewController: CustomButtonDelegate {
    func buttonDidTap(_ sender: CustomButton) {
        dismiss(animated: true, completion: nil)
    }
}
