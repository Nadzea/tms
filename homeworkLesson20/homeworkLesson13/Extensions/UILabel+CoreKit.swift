//
//  UILabel+CoreKit.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 11.08.21.
//

import UIKit

extension UILabel {
    func addAttributedText(with strokeColor: UIColor, foregroundColor: UIColor, strokeWidth : Int, size: CGFloat) {
        self.attributedText = NSAttributedString(string: self.text!,
                                                     attributes: [
                                                        .strokeColor : strokeColor,
                                                        .foregroundColor : foregroundColor,
                                                        .strokeWidth: strokeWidth,
                                                        .font: UIFont.styleScript(with: size)])
    }
    
}
