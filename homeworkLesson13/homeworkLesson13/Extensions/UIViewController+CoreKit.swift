//
//  UIViewController+CoreKit.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 26.07.21.
//

import UIKit

extension UIViewController {
    func addGradient(with color1: CGColor, color2: CGColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [color1, color2]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.type = .axial
        
    }
    
}
