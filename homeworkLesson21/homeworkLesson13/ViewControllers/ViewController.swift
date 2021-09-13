//
//  ViewController.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 24.07.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playButton: CustomButtonMainView!
    @IBOutlet weak var resultsButton: CustomButtonMainView!
    @IBOutlet weak var settingsButton: CustomButtonMainView!
    @IBOutlet weak var aboutButton: CustomButtonMainView!
    
    let storyboards: [String] = ["PlayerNamesViewController", "ResultsViewController", "SettingsViewController", "AboutChessViewController"]
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let manager = FileManager.default

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton.delegate = self
        resultsButton.delegate = self
        settingsButton.delegate = self
        aboutButton.delegate = self
        
        playButton.addShadow(with: .black, opacity: 0.9, shadowOffset: CGSize(width: 10, height: 10))
        resultsButton.addShadow(with: .black, opacity: 0.9, shadowOffset: CGSize(width: 5, height: 5))
        settingsButton.addShadow(with: .black, opacity: 0.9, shadowOffset: CGSize(width: 5, height: 5))
    
    }
    
    func getViewController(with storyboard: String) -> UIViewController {
        
        let currentStoryboard = UIStoryboard(name: storyboard, bundle: nil)
        let currentViewController = currentStoryboard.instantiateInitialViewController()
        currentViewController?.modalPresentationStyle = .fullScreen
        currentViewController?.modalTransitionStyle = .coverVertical
        return currentViewController!
        
    }
    
}
extension ViewController: CustomButtonMainViewDelegate {
    func buttonDidTap(_ sender: CustomButtonMainView) {
        let vc = self.getViewController(with: storyboards[sender.tag])
        
        (vc as? PlayerNamesViewController)?.viewControllerDidDismiss = {
            self.present(self.getViewController(with: "PlayViewController"), animated: true, completion: nil)
        }
        
        if sender.tag == 0 {
            guard manager.fileExists(atPath: documentDirectory.appendingPathComponent("savedGame").path) else { present(vc, animated: true, completion: nil)
                return
            }
            presentAlertController(with: nil, message: "Do you want to continue the saved game?",
                                   actions: UIAlertAction(title: "New game",
                                                          style: .default,
                                                          handler: { _ in
                                                            SaveData.deleteSavedGame()
                                                            self.view.removeBlurView()
                                                            self.present(vc, animated: true, completion: nil)}),
                                            UIAlertAction(title: "Saved game",
                                                          style: .default,
                                                          handler: { _ in
                                                            self.view.removeBlurView()
                                                            self.present(self.getViewController(with: "PlayViewController"), animated: true, completion: nil)}))
        } else {
            present(vc, animated: true, completion: nil)
        }
    }
}



