//
//  UIFont+CoreKit.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 13.08.21.
//

import UIKit

extension UIFont {
    static func styleScript(with size: CGFloat) -> UIFont {
        return UIFont(name: "StyleScript-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
