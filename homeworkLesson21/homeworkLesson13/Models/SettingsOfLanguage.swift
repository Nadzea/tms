//
//  SettingsOfLanguage.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 15.09.21.
//

import UIKit

class SettingsOfLanguage: NSObject, NSCoding, NSSecureCoding {
    static var supportsSecureCoding: Bool = true
    
    var language: String
    var stateSwitch: Bool
    
    init(language: String, stateSwitch: Bool) {
        self.language = language
        self.stateSwitch = stateSwitch
    }
    
    func encode(with coder: NSCoder) { // КОДИРОВКА
        coder.encode(language, forKey: "language")
        coder.encode(stateSwitch, forKey: "stateSwitch")
    }
    
    required init?(coder: NSCoder) { // ДЕКОДИРОВКА
        self.language = coder.decodeObject(forKey: "language") as! String
        self.stateSwitch = coder.decodeBool(forKey: "stateSwitch")

    }
}
