//
//  ResultsViewController.swift
//  homeworkLesson12
//
//  Created by Надежда Клименко on 21.07.21.
//

import UIKit

class ResultsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    }
    @IBAction func resultsBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
