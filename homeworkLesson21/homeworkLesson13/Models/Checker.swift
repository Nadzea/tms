//
//  Checker.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 9.08.21.
//

import UIKit

class Checker: NSObject, NSCoding, NSSecureCoding {
    static var supportsSecureCoding: Bool = true
    
    var colorTag: Int?
    var positionTag: Int?
    
    init(colorTag: Int?, positionTag: Int?) {
        self.colorTag = colorTag
        self.positionTag = positionTag
    }
    
    func encode(with coder: NSCoder) { // КОДИРОВКА
        coder.encode(colorTag, forKey: "color")
        coder.encode(positionTag, forKey: "position")
    }
    
    required init?(coder: NSCoder) { // ДЕКОДИРОВКА
        self.colorTag = coder.decodeObject(forKey: "color") as? Int
        self.positionTag = coder.decodeObject(forKey: "position") as? Int
    }
}
