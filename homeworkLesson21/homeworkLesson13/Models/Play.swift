//
//  Play.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 23.09.21.
//

import UIKit

class Play {
    var dateOfPlay: Date?
    var players: [Player]?
    
    init(from play: PlayDB) {
        self.dateOfPlay = play.dateOfPlay
    }
    
    init(dateOfPlay: Date, players: [Player]) {
        self.dateOfPlay = dateOfPlay
        self.players = players
    }
}
