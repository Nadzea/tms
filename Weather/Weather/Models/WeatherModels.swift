//
//  WeatherData.swift
//  Weather
//
//  Created by Надежда Клименко on 5.09.21.
//

import Foundation

struct Weather {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct Main {
    var temp: Double?
    var feels_like: Double?
    var pressure: Int?
    var humidity: Int?
}

struct Sys {
    var country: String?
}

struct Wind {
    var speed: Float?
    var deg: Int?
}

struct List  {
    var main: Main = Main()
    var weather: [Weather] = []
    var wind: Wind = Wind()
    var dt: Int?
    var dt_txt: String?
}

struct WeatherDataForFiveDays {
    var list: [List] = []
}
