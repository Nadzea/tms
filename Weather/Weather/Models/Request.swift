//
//  Request.swift
//  Weather
//
//  Created by Надежда Клименко on 7.10.21.
//

import UIKit
import RealmSwift

class Request: Object {
    @Persisted var dateOfRequest: Date = Date()
    @Persisted var cityName: String = ""
    @Persisted var temperature: Int = 0
    @Persisted var tempFeelLikes: Int = 0
    @Persisted var descriptionLabel: String = ""
    @Persisted var wind: String = ""
    
    convenience init(dateOfRequest: Date, cityName: String, temperature: Int, tempFeelLikes: Int, descriptionLabel: String, wind: String) {
        self.init()
        
        self.dateOfRequest = dateOfRequest
        self.cityName = cityName
        self.temperature = temperature
        self.tempFeelLikes = tempFeelLikes
        self.descriptionLabel = descriptionLabel
        self.wind = wind
        
    }
    
    
    
    
    
}
