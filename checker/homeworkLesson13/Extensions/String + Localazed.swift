//
//  String + Localazed.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 17.09.21.
//

import UIKit

extension String {
    var localized: String {
        guard let languagePath = Bundle.main.path(forResource: SettingsManager.shared.currentLanguageCode, ofType: "lproj"), let languageBundle = Bundle(path: languagePath) else { return self }
        
        return NSLocalizedString(self, bundle: languageBundle, value: "", comment: "")
    }
}
