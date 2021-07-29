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
}
