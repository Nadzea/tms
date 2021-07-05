//
//  Singer.swift
//  homeworkLesson7HandIn
//
//  Created by Надежда Клименко on 4.07.21.
//

import Foundation

class Singer: Artist {
    
    override func performance() -> String {
        return super.performance() + " " + "sings"
    }
    
}
