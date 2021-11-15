//
//  Journey.swift
//  swiftUIProject
//
//  Created by Надежда Клименко on 13.11.21.
//

import Foundation

struct Journey: Identifiable, Hashable {
    var id = UUID() 
    var imageName: String
    var country: String
    var dateOfJourney: String
    var description: String
    
    init(imageName: String, country: String, description: String) {
        self.imageName = imageName
        self.country = country
        self.description = description
        let month: [String] = ["January, ", "February, ", "March, ", "April, ", "May, ", "June, ", "July, ", "August, ", "September, ", "October, ", "November, ", "December, "]
        self.dateOfJourney = month.randomElement()! + String(Int.random(in: 2014...2020)) 
    }
}
