//
//  PlayerDB+CoreDataProperties.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 23.09.21.
//
//

import Foundation
import CoreData


extension PlayerDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerDB> {
        return NSFetchRequest<PlayerDB>(entityName: "PlayerDB")
    }

    @NSManaged public var name: String?
    @NSManaged public var colorOfChecker: String?
    @NSManaged public var winner: Bool
    @NSManaged public var playDB: PlayDB?
    
    func convert(by player: Player) {
        self.name = player.name
        self.colorOfChecker = player.colorOfChecker
        self.winner = player.winner
        
    }

}

extension PlayerDB : Identifiable {

}
