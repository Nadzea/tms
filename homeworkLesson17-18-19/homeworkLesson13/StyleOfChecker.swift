//
//  StyleOfChecker.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 13.08.21.
//

import UIKit

class StyleOfChecker: NSObject, NSCoding, NSSecureCoding {
    static var supportsSecureCoding: Bool = true
    
    var whiteChecker: String?
    var blackChecker: String?
    var stateSwitch: Bool?
    
//    override init() {
//        super.init()
//    }
    init(whiteChecker: String, blackChecker: String, stateSwitch: Bool) {
        self.whiteChecker = whiteChecker
        self.blackChecker = blackChecker
        self.stateSwitch = stateSwitch
    }
    
    func encode(with coder: NSCoder) { // КОДИРОВКА
        coder.encode(whiteChecker, forKey: "whiteChecker")
        coder.encode(blackChecker, forKey: "blackChecker")
        coder.encode(stateSwitch, forKey: "stateSwitch")
    }
    
    required init?(coder: NSCoder) { // ДЕКОДИРОВКА
        self.whiteChecker = coder.decodeObject(forKey: "whiteChecker") as? String
        self.blackChecker = coder.decodeObject(forKey: "blackChecker") as? String
        self.stateSwitch = coder.decodeObject(forKey: "stateSwitch") as? Bool

    }
}
