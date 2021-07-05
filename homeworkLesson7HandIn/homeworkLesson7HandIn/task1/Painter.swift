//
//  Painter.swift
//  homeworkLesson7HandIn
//
//  Created by Надежда Клименко on 4.07.21.
//

import Foundation

class Painter: Artist {
    override init(firstName: String, lastName: String) {
        super.init(firstName: "Ganz", lastName: "Kuni")
    }
    
    override func performance() -> String {
        return super.performance() + " " + "draws"
    }
    
}

