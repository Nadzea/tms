//
//  UIViewController+CoreKit.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 26.07.21.
//

import UIKit

extension UIViewController {
    
    @discardableResult
    func presentAlertController(with title: String?, message: String?, preferredStyle: UIAlertController.Style = .alert, actions: UIAlertAction...) -> UIAlertController {
        
        self.view.addBlurView()
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        let cancel = UIAlertAction(title: "alert_title3_text".localized, style: .cancel, handler: { _ in
            self.view.removeBlurView()
        })
        
        actions.forEach { alert.addAction($0) }
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
        return alert
    }
    
    func screenSettings(buttonLabel: UILabel, blurView: UIVisualEffectView) {
        
        buttonLabel.text = "button_label".localized
        let currentLanguage = SaveData.getSaveCurrentLanguage()
        if currentLanguage == "ru" {
            buttonLabel.addAttributedTextWithLavanderiaScript(with: .black, foregroundColor: .black, strokeWidth: -2, size: 30)
        } else {
            buttonLabel.addAttributedText(with: .black, foregroundColor: .black, strokeWidth: -2, size: 30)
        }
        
        blurView.layer.cornerRadius = 20
    }
    
    func getViewController(with storyboard: String) -> UIViewController {
        
        let currentStoryboard = UIStoryboard(name: storyboard, bundle: nil)
        let currentViewController = currentStoryboard.instantiateInitialViewController()
        currentViewController?.modalPresentationStyle = .fullScreen
        currentViewController?.modalTransitionStyle = .crossDissolve
        return currentViewController!
    }
}
