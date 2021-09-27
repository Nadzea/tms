//
//  Player.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 23.09.21.
//

import UIKit

class Player {
    var name: String?
    var colorOfChecker: String?
    var winner: Bool = false
    var playDB: PlayDB?
    
    init(name: String?, colorOfChecker: String?, winner: Bool) {
        self.name = name
        self.colorOfChecker = colorOfChecker
        self.winner = winner
    }
}
