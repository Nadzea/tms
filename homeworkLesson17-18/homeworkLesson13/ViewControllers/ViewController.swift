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
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let manager = FileManager.default

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
        
        if sender.tag == 0 && manager.fileExists(atPath: documentDirectory.appendingPathComponent("checkers").path)  {
            presentAlertController(with: nil, message: "Do you want to continue the saved game?",
                                   actions: UIAlertAction(title: "New game",
                                                          style: .default,
                                                          handler: { _ in
                                                    
                                                            try? self.manager.removeItem(atPath: self.documentDirectory.appendingPathComponent("checkers").path)
                                                            
                                                            self.view.removeBlurView()
                                                            
                                                            self.present(self.getViewController(with: self.storyboards[0]), animated: true, completion: nil)}),
                                            UIAlertAction(title: "Saved game",
                                                          style: .default,
                                                          handler: { _ in
                                                            self.view.removeBlurView()
                                                            self.present(self.getViewController(with: self.storyboards[0]), animated: true, completion: nil)}))
        }
        present(getViewController(with: storyboards[sender.tag]), animated: true, completion: nil)
    }
    
}

