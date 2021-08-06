//
//  Student.swift
//  homeworkLesson16
//
//  Created by Надежда Клименко on 5.08.21.
//

import UIKit

class Student {
    let firstName: String
    let lastName: String
    var averageMark: Float
    
    init(firstName: String, lastName: String, averageMark: Float) {
        self.firstName = firstName
        self.lastName = lastName
        self.averageMark = averageMark
    }
}
