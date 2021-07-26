//
//  ResultsViewController.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 24.07.21.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var backResultsScreen: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGradient(with: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), color2: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        
        backResultsScreen.addShadow(with: .black, opacity: 0.5, shadowOffset: CGSize(width: 10, height: 10))
        
    }
    
    @IBAction func backResultsScreen(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
