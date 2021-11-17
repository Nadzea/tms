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
    var lady: Bool
    
    init(colorTag: Int?, positionTag: Int?, lady: Bool) {
        self.colorTag = colorTag
        self.positionTag = positionTag
        self.lady = lady
    }
    
    func encode(with coder: NSCoder) { // КОДИРОВКА
        coder.encode(colorTag, forKey: "color")
        coder.encode(positionTag, forKey: "position")
        coder.encode(lady, forKey: "lady")
    }
    
    required init?(coder: NSCoder) { // ДЕКОДИРОВКА
        self.colorTag = coder.decodeObject(forKey: "color") as? Int
        self.positionTag = coder.decodeObject(forKey: "position") as? Int
        self.lady = coder.decodeBool(forKey: "lady")
    }
}
