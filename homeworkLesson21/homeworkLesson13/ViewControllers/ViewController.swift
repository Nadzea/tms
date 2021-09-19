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
    
    let storyboards: [String] = ["PlayerNamesViewController", "ResultsViewController", "NewSettingsViewController", "AboutChessViewController"]
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let manager = FileManager.default

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton.delegate = self
        resultsButton.delegate = self
        settingsButton.delegate = self
        aboutButton.delegate = self
        //localized()
        screenSettings()
        
        
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        localized()
        attributed()
    }
    
    func screenSettings() {
        playButton.addShadow(with: .black, opacity: 0.9, shadowOffset: CGSize(width: 10, height: 10))
        resultsButton.addShadow(with: .black, opacity: 0.9, shadowOffset: CGSize(width: 5, height: 5))
        settingsButton.addShadow(with: .black, opacity: 0.9, shadowOffset: CGSize(width: 5, height: 5))
    }
    
    func attributed() {
        
            let currentLanguage = SaveData.getSaveCurrentLanguage()
            
            playButton.buttonLabel.font = currentLanguage == "ru" ? UIFont(name: "LavanderiaC", size: 30) : UIFont(name: "StyleScript-Regular", size: 35)
            resultsButton.buttonLabel.font = currentLanguage == "ru" ? UIFont(name: "LavanderiaC", size: 30) : UIFont(name: "StyleScript-Regular", size: 35)
            settingsButton.buttonLabel.font = currentLanguage == "ru" ? UIFont(name: "LavanderiaC", size: 30) : UIFont(name: "StyleScript-Regular", size: 35)
            aboutButton.buttonLabel.font = currentLanguage == "ru" ? UIFont(name: "LavanderiaC", size: 30) : UIFont(name: "StyleScript-Regular", size: 35)
        
    }
    
    func localized() {
        playButton.buttonLabel.text = "play_button_text".localized
        resultsButton.buttonLabel.text = "results_button_text".localized
        settingsButton.buttonLabel.text = "settings_button_text".localized
        aboutButton.buttonLabel.text = "about_button_text".localized

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
            presentAlertController(with: nil, message: "alert_message_text".localized,
                                   actions: UIAlertAction(title: "alert_title1_text".localized,
                                                          style: .default,
                                                          handler: { _ in
                                                            SaveData.deleteSavedGame()
                                                            self.view.removeBlurView()
                                                            self.present(vc, animated: true, completion: nil)}),
                                            UIAlertAction(title: "alert_title2_text".localized,
                                                          style: .default,
                                                          handler: { _ in
                                                            self.view.removeBlurView()
                                                            self.present(self.getViewController(with: "PlayViewController"), animated: true, completion: nil)}))
        } else {
            present(vc, animated: true, completion: nil)
        }
    }
}



