//
//  ViewController.swift
//  homeworkLesson12
//
//  Created by Надежда Клименко on 20.07.21.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let color1 = UIColor(red: 80/255, green: 100/255, blue: 255/255, alpha: 1).cgColor
        let color2 = UIColor(red: 50/255, green: 150/255, blue: 50/255, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [color1, color2]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    func getViewController(from id: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let currentViewController = storyboard.instantiateViewController(withIdentifier: id)
        currentViewController.modalPresentationStyle = .fullScreen
        currentViewController.modalTransitionStyle = .flipHorizontal
        return currentViewController
    }
    @IBAction func playButton(_ sender: Any) {
        present(getViewController(from: "PlayViewController"), animated: true, completion: nil)
    }
    @IBAction func resultsButton(_ sender: Any) {
        present(getViewController(from: "ResultsViewController"), animated: true, completion: nil)
    }
    @IBAction func settingsButton(_ sender: Any) {
        present(getViewController(from: "SettingsViewController"), animated: true, completion: nil)
    }
}

