//
//  ViewController.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 24.07.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainViewButtonAbout: UIVisualEffectView!
    @IBOutlet weak var secondViewButtonAbout: UIView!
    
    let storyboards: [String] = ["PlayViewController", "ResultsViewController", "SettingsViewController", "AboutChessViewController"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGradient(with: #colorLiteral(red: 0.4588212766, green: 0.9733110408, blue: 0.9392217259, alpha: 1), #colorLiteral(red: 0.4154809965, green: 0.6327818212, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        
        secondViewButtonAbout.addGradient(with: #colorLiteral(red: 0.4588212766, green: 0.9733110408, blue: 0.9392217259, alpha: 1), #colorLiteral(red: 0.4154809965, green: 0.6327818212, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        mainViewButtonAbout.layer.cornerRadius = mainViewButtonAbout.frame.height / 2
        secondViewButtonAbout.layer.cornerRadius = mainViewButtonAbout.frame.height / 3
    
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

