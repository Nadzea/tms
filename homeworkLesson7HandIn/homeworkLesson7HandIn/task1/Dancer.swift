//
//  Dancer.swift
//  homeworkLesson7HandIn
//
//  Created by Надежда Клименко on 4.07.21.
//

import Foundation

class Dancer: Artist {
    
    override func performance() -> String {
        return super.performance() + " " + "dances"
    }
    
}
