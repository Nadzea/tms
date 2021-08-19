//
//  UIViewController+CoreKit.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 26.07.21.
//

import UIKit

extension UIViewController {
    
    @discardableResult
    func presentAlertController(with title: String?, message: String, preferredStyle: UIAlertController.Style = .alert, actions: UIAlertAction...) -> UIAlertController {
        
        self.view.addBlurView()
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            self.view.removeBlurView()
        })
        
        actions.forEach { alert.addAction($0) }
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
        return alert
    }
}
