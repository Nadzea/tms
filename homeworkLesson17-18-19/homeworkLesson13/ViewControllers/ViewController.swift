//
//  ViewController.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 24.07.21.
//

import UIKit

let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
let manager = FileManager.default

func deleteSavedGame() {
    try? manager.removeItem(atPath: documentDirectory.appendingPathComponent("checkers").path)
}

class ViewController: UIViewController{
    
    @IBOutlet weak var playButton: CustomButtonMainView!
    @IBOutlet weak var resultsButton: CustomButtonMainView!
    @IBOutlet weak var settingsButton: CustomButtonMainView!
    @IBOutlet weak var aboutButton: CustomButtonMainView!
    
    let storyboards: [String] = ["PlayViewController", "ResultsViewController", "SettingsViewController", "AboutChessViewController"]
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let manager = FileManager.default

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton.delegate = self
        resultsButton.delegate = self
        settingsButton.delegate = self
        aboutButton.delegate = self
        
        self.view.addGradient(with: #colorLiteral(red: 0.4588212766, green: 0.9733110408, blue: 0.9392217259, alpha: 1), #colorLiteral(red: 0.4803237184, green: 0.7373365856, blue: 0.8808781744, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
    
    }
    
    func getViewController(with storyboard: String) -> UIViewController {
        let currentStoryboard = UIStoryboard(name: storyboard, bundle: nil)
        let currentViewController = currentStoryboard.instantiateInitialViewController()
        currentViewController?.modalPresentationStyle = .fullScreen
        currentViewController?.modalTransitionStyle = .flipHorizontal
        return currentViewController!
    }
    
}
extension ViewController: CustomButtonMainViewDelegate {
    func buttonDidTap(_ sender: CustomButtonMainView) {
        if sender.tag == 0 {
        guard manager.fileExists(atPath: documentDirectory.appendingPathComponent("checkers").path) else { present(getViewController(with: storyboards[sender.tag]), animated: true, completion: nil)
            return
        }
            presentAlertController(with: nil, message: "Do you want to continue the saved game?",
                                   actions: UIAlertAction(title: "New game",
                                                          style: .default,
                                                          handler: { _ in
                                                            deleteSavedGame()
                                                            self.view.removeBlurView()
                                                            self.present(self.getViewController(with: self.storyboards[sender.tag]), animated: true, completion: nil)}),
                                            UIAlertAction(title: "Saved game",
                                                          style: .default,
                                                          handler: { _ in
                                                            self.view.removeBlurView()
                                                            self.present(self.getViewController(with: self.storyboards[sender.tag]), animated: true, completion: nil)}))
        } else {
            present(getViewController(with: storyboards[sender.tag]), animated: true, completion: nil)
        }
    }
}

