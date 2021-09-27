//
//  SettingsManager.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 17.09.21.
//

import UIKit

class SettingsManager {
    static let shared = SettingsManager()
    
    var currentLanguageCode: String {
        set {
            
            SaveData.saveCurrentLanguage(currentLanguageCode: newValue)
    
        }
        
        get {
            var lan = "en"
            if manager.fileExists(atPath: documentDirectory.appendingPathComponent("currentLanguageCode").path) {
                lan = SaveData.getSaveCurrentLanguage()
            }
            
            return lan
        }
    }
}
