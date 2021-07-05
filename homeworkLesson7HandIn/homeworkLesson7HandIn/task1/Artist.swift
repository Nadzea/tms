//
//  Artist.swift
//  homeworkLesson7HandIn
//
//  Created by Надежда Клименко on 4.07.21.
//

import Foundation

class Artist {
    let firstName: String
    let lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func performance () -> String {
        print("___________________")
        print(firstName, lastName)
        return "This artist"
        
    }
}

