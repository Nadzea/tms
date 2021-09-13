//
//  SavedData.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 26.08.21.
//

import UIKit

let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
let manager = FileManager.default

class SaveData:  NSObject, NSCoding, NSSecureCoding {
    static var supportsSecureCoding: Bool = true
    
    var savedCheckersPosition: [Checker?]
    var savedStyleOfCheckers: StyleOfChecker?
    var savedCountSeconds: Int?
    var savedCountMinutes: Int?
    var savedCurrentChecker: Int?
    var nameOfPlayer1: String?
    var nameOfPlayer2: String?
    var savedDateOfStartGame: String?
    
    
    init(savedCheckersPosition: [Checker?], savedStyleOfCheckers: StyleOfChecker?, savedCountSeconds: Int?, savedCountMinutes: Int?, savedCurrentChecker: Int?, nameOfPlayer1: String?, nameOfPlayer2: String?) {
        self.savedCheckersPosition = savedCheckersPosition
        self.savedStyleOfCheckers = savedStyleOfCheckers
        self.savedCountSeconds = savedCountSeconds
        self.savedCountMinutes = savedCountMinutes
        self.savedCurrentChecker = savedCurrentChecker
        self.nameOfPlayer1 = nameOfPlayer1
        self.nameOfPlayer2 = nameOfPlayer2
    }
    
    init(savedCheckersPosition: [Checker?], savedCountSeconds: Int?, savedCountMinutes: Int?, savedCurrentChecker: Int?, nameOfPlayer1: String?, nameOfPlayer2: String?, date: String?) {
        self.savedCheckersPosition = savedCheckersPosition
        self.savedCountSeconds = savedCountSeconds
        self.savedCountMinutes = savedCountMinutes
        self.savedCurrentChecker = savedCurrentChecker
        self.nameOfPlayer1 = nameOfPlayer1
        self.nameOfPlayer2 = nameOfPlayer2
        self.savedDateOfStartGame = date
    }
    
    
    func encode(with coder: NSCoder) { // КОДИРОВКА
        coder.encode(savedCheckersPosition, forKey: "savedCheckersPosition")
        coder.encode(savedStyleOfCheckers, forKey: "savedStyleOfCheckers")
        coder.encode(savedCountSeconds, forKey: "savedCountSeconds")
        coder.encode(savedCountMinutes, forKey: "savedCountMinutes")
        coder.encode(savedCurrentChecker, forKey: "savedCurrentChecker")
        coder.encode(nameOfPlayer1, forKey: "nameOfPlayer1")
        coder.encode(nameOfPlayer2, forKey: "nameOfPlayer2")
        coder.encode(savedDateOfStartGame, forKey: "date")
    }
    
    required init?(coder: NSCoder) { // ДЕКОДИРОВКА
        self.savedCheckersPosition = coder.decodeObject(forKey: "savedCheckersPosition") as? [Checker] ?? []
        self.savedStyleOfCheckers = coder.decodeObject(forKey: "savedStyleOfCheckers") as? StyleOfChecker
        self.savedCountSeconds = coder.decodeObject(forKey: "savedCountSeconds") as? Int
        self.savedCountMinutes = coder.decodeObject(forKey: "savedCountMinutes") as? Int
        self.savedCurrentChecker = coder.decodeObject(forKey: "savedCurrentChecker") as? Int
        self.nameOfPlayer1 = coder.decodeObject(forKey: "nameOfPlayer1") as? String
        self.nameOfPlayer2 = coder.decodeObject(forKey: "nameOfPlayer2") as? String
        self.savedDateOfStartGame = coder.decodeObject(forKey: "date") as? String
    }
    
    
    static func savedNameOfPlayer(nameOfPlayer1: String, nameOfPlayer2: String) {
        let names = [nameOfPlayer1, nameOfPlayer2]
        let data1 = try? NSKeyedArchiver.archivedData(withRootObject: names, requiringSecureCoding: true)
        let fileURL = documentDirectory.appendingPathComponent("savedNames")
        try? data1?.write(to: fileURL)
    }
    
    static func getNamesOfPlayers() -> [String] {
        let fileURL = documentDirectory.appendingPathComponent("savedNames")
        
        guard let data = FileManager.default.contents(atPath: fileURL.absoluteString.replacingOccurrences(of: "file://", with: "")) else { return [] }
        
        let nameOfPlayers = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String]
        
        return(nameOfPlayers ?? [])
    }
    
    static func deleteSavedNames() {
        try? manager.removeItem(atPath: documentDirectory.appendingPathComponent("savedNames").path)
    }
    
    static func saveStyleOfChecker(styleOfCheckers: [StyleOfChecker]) {
        let data = try? NSKeyedArchiver.archivedData(withRootObject: styleOfCheckers, requiringSecureCoding: true)
        let fileURL = documentDirectory.appendingPathComponent("styleOfChecker")
        try? data?.write(to: fileURL)
    }
    
    static func getStyleChecker() -> [StyleOfChecker] {
        let fileURL = documentDirectory.appendingPathComponent("styleOfChecker")
        
        guard let data = FileManager.default.contents(atPath: fileURL.absoluteString.replacingOccurrences(of: "file://", with: "")) else { return [] }
        
        let stylesOfChecker = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [StyleOfChecker]
        return (stylesOfChecker ?? [])
    }
    
    static func saveImageForScreen(image: UIImage) {
        let data = image.pngData()
        
        let fileURL = documentDirectory.appendingPathComponent("imageForPlayScreen")
            try? data?.write(to: fileURL)
    }
    
    static func getImageForScreen() -> UIImage {
        let fileURL = documentDirectory.appendingPathComponent("imageForPlayScreen")
            
        guard let data = FileManager.default.contents(atPath: fileURL.absoluteString.replacingOccurrences(of: "file://", with: "")) else { return UIImage() }
            
        let image = UIImage(data: data)
        return (image ?? UIImage())
    }
    
    static func saveGame(saveData: SaveData) {
        let data = try? NSKeyedArchiver.archivedData(withRootObject: saveData, requiringSecureCoding: true)
        let fileURL = documentDirectory.appendingPathComponent("savedGame")
        try? data?.write(to: fileURL)
    }
    
    static func getSaveGame() -> SaveData {
        let test = SaveData(savedCheckersPosition: [], savedCountSeconds: nil, savedCountMinutes: nil, savedCurrentChecker: nil, nameOfPlayer1: "", nameOfPlayer2: "", date: "")
        let fileURL = documentDirectory.appendingPathComponent("savedGame")
        
        guard let data = FileManager.default.contents(atPath: fileURL.absoluteString.replacingOccurrences(of: "file://", with: "")) else { return test }
        
        let save = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? SaveData
        
        return(save ?? test) 
    }
    
    static func deleteSavedGame() {
        try? manager.removeItem(atPath: documentDirectory.appendingPathComponent("savedGame").path)
    }

    
}
