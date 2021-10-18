//
//  UIViewController + Storyboard.swift
//  Weather
//
//  Created by Надежда Клименко on 14.10.21.
//

import UIKit

extension UIViewController {
    static func getViewController(by identifier: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: identifier, bundle: nil)
        return storyboard.instantiateInitialViewController()
    }
}

