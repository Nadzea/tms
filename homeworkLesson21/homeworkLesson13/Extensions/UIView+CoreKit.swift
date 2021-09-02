//
//  UIView+CoreKit.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 25.07.21.
//

import UIKit

extension UIView {
    
    func addShadow(with color: UIColor, opacity: Float, shadowOffset: CGSize = .zero) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = self.layer.cornerRadius //чтобы радиус тени был равен радиусу фигуры
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = shadowOffset
    }
    
    func addGradient(with colors: CGColor...) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        self.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.type = .axial
    }
    
    func addBorder(with borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
    }
    
    func addBlurView() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = bounds
        blurView.tag = 10
        addSubview(blurView)
    }
    
    func removeBlurView() {
        self.subviews.first(where: {$0.tag == 10})?.removeFromSuperview()
    }
}

