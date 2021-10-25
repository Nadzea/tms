//
//  RealmManager.swift
//  Weather
//
//  Created by Надежда Клименко on 7.10.21.
//

import UIKit
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    let localRealm = try! Realm()
    
    func createRequest(weatherData: WeatherData, date: Date) {
        let tempC = Int(round(weatherData.main.temp - 273.15))
        let tempFeelLikes = Int(round(weatherData.main.feels_like - 273.15))
        let wind: String = weatherData.wind.deg.typeOfWind()  + "\(weatherData.wind.speed)m/s"
        
        
//        switch weatherData.wind.deg {
//        case 0...11, 349...360:
//            wind = "north \(weatherData.wind.speed)m/s"
//        case 12...78:
//            wind = "northeast \(weatherData.wind.speed)m/s"
//        case 79...101:
//            wind = "east \(weatherData.wind.speed)m/s"
//        case 102...168:
//            wind = "southeast \(weatherData.wind.speed)m/s"
//        case 169...191:
//            wind = "south \(weatherData.wind.speed)m/s"
//        case 192...258:
//            wind = "southwest \(weatherData.wind.speed)m/s"
//        case 259...281:
//            wind = "west \(weatherData.wind.speed)m/s"
//        case 282...348:
//            wind = "northwest \(weatherData.wind.speed)m/s"
//        default:
//            wind = ""
//        }
        let request = Request(dateOfRequest: date, cityName: weatherData.name, temperature: tempC, tempFeelLikes: tempFeelLikes, descriptionLabel: weatherData.weather[0].description, wind: wind)
        
        do {
            try localRealm.write {
                localRealm.add(request)
                print("realm")
            }
        } catch(let e) {
            print(e)
        }
    }
    
    func getAllRequest() -> [Request] {
        let requests = localRealm.objects(Request.self)
        
        return requests.reversed()
    }
}
