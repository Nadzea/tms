//
//  CoreDataManager.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 22.09.21.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ResultsOfPlay")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("SAVED")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func savePlay(by play: Play) {
        let playDB = PlayDB(context: persistentContainer.viewContext)
        playDB.dateOfPlay = play.dateOfPlay
        play.players?.forEach({ player in
            let playerDB = PlayerDB(context: persistentContainer.viewContext)
            playerDB.convert(by: player)
            playDB.addToPlayerDB(playerDB)
        })
        persistentContainer.viewContext.insert(playDB)
        
        saveContext()
    }
    
    func getPlays() -> [Play] {
        var array: [Play] = []
        do {
            let plays = try persistentContainer.viewContext.fetch(PlayDB.fetchRequest())
            plays.forEach { play in
                guard let play = play as? PlayDB else { return }
                array.append(Play(from: play))
            }
        } catch (let e) {
            print(e)
        }
        return array
    }
    
//    func getPlayer(by play: Play) -> [Player] {
//        let requst: NSFetchRequest<PlayDB> = PlayDB.fetchRequest()
//        requst.predicate = NSPredicate(format: "dateOfPlay == %@", play.dateOfPlay! as CVarArg)
//
//        var players: [Player] = []
//
//        do {
//            guard let play = try persistentContainer.viewContext.fetch(requst).first else { return [] }
//            play.playerDB?.allObjects.forEach({ playerDB in
//                guard let playerDB = playerDB as? PlayerDB else { return }
//                let player = Player(name: playerDB.name, colorOfChecker: playerDB.colorOfChecker, winner: playerDB.winner)
//                players.append(player)
//            })
//            saveContext()
//        } catch (let e) {
//            print(e)
//        }
//
//        return players
//    }
    
    func deleteAllData() {

        do {
            let plays = try persistentContainer.viewContext.fetch(PlayDB.fetchRequest())
            plays.forEach { play in
                guard let play = play as? PlayDB else { return }
                persistentContainer.viewContext.delete(play)
                saveContext()
            }
        } catch (let e) {
            print(e)
        }
    }
}
