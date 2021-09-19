//
//  UIView + Localized.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 17.09.21.
//

import UIKit

extension UIView {
    @IBInspectable var localizedName: String {
        get {
            return self.localizedName
        }
        
        set {
            if let label = self as? UILabel {
                label.text = NSLocalizedString(newValue, comment: "")
            }
            
            if let button = self as? UIButton {
                button.setTitle(NSLocalizedString(newValue, comment: ""), for: .normal)
            }
        }
    }
}
