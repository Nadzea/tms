//
//  Int.swift
//  Weather
//
//  Created by Надежда Клименко on 17.10.21.
//

import UIKit

extension Int {
    func typeOfWind() -> String {
        switch self {
        case 0...11, 349...360:
            return "Wind: north "
        case 12...78:
            return "Wind: northeast "
        case 79...101:
            return "Wind: east "
        case 102...168:
            return "Wind: southeast "
        case 169...191:
            return "Wind: south "
        case 192...258:
            return "Wind: southwest "
        case 259...281:
            return "Wind: west "
        case 282...348:
            return "Wind: northwest "
        default:
            return ""
        }
    }
    
    func typeOfVideo() -> String {
        var pathVideo: String = ""
        switch self {
        case 200, 201, 210, 211, 230, 231:
            pathVideo = Bundle.main.path(forResource: "thunderstorm", ofType: "mp4") ?? ""
        case 202, 232:
            pathVideo = Bundle.main.path(forResource: "thunderstormWithRain", ofType: "mp4") ?? ""
        case 212, 221:
            pathVideo = Bundle.main.path(forResource: "heavyThunderstorm", ofType: "mp4") ?? ""
        case 501, 521, 531:
            pathVideo = Bundle.main.path(forResource: "rain", ofType: "mp4") ?? ""
        case 503, 502, 520, 522:
            pathVideo = Bundle.main.path(forResource: "veryHeavyRain", ofType: "mp4") ?? ""
        case 500:
            pathVideo = Bundle.main.path(forResource: "lightRain", ofType: "mp4") ?? ""
        case 800:
            pathVideo = Bundle.main.path(forResource: "clearSky", ofType: "mp4") ?? ""
        case 801:
            pathVideo = Bundle.main.path(forResource: "fewClouds 2", ofType: "mp4") ?? ""
        case 802:
            pathVideo = Bundle.main.path(forResource: "scatteredСlouds", ofType: "mp4") ?? ""
        case 803:
            pathVideo = Bundle.main.path(forResource: "brokenСlouds", ofType: "mp4") ?? ""
        case 804:
            pathVideo = Bundle.main.path(forResource: "overcastClouds", ofType: "mp4") ?? ""
        default: break
        }
        return pathVideo
    }
    
}
