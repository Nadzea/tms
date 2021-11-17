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
        self.players = play.playerDB?.allObjects.compactMap({ value -> Player in
            let value = value as! PlayerDB
            let player = Player(name: value.name, colorOfChecker: value.colorOfChecker, winner: value.winner)
            return player
        })
    }
    
    init(dateOfPlay: Date, players: [Player]) {
        self.dateOfPlay = dateOfPlay
        self.players = players
    }
}
