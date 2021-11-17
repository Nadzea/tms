//
//  PlayDB+CoreDataProperties.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 23.09.21.
//
//

import Foundation
import CoreData


extension PlayDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayDB> {
        return NSFetchRequest<PlayDB>(entityName: "PlayDB")
    }

    @NSManaged public var dateOfPlay: Date?
    @NSManaged public var playerDB: NSSet?

}

// MARK: Generated accessors for playerDB
extension PlayDB {

    @objc(addPlayerDBObject:)
    @NSManaged public func addToPlayerDB(_ value: PlayerDB)

    @objc(removePlayerDBObject:)
    @NSManaged public func removeFromPlayerDB(_ value: PlayerDB)

    @objc(addPlayerDB:)
    @NSManaged public func addToPlayerDB(_ values: NSSet)

    @objc(removePlayerDB:)
    @NSManaged public func removeFromPlayerDB(_ values: NSSet)

}

extension PlayDB : Identifiable {

}
