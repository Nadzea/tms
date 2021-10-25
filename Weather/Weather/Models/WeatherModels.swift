//
//  WeatherData.swift
//  Weather
//
//  Created by Надежда Клименко on 5.09.21.
//

import Foundation

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Main: Codable {
    var temp: Double = 0.0
    var feels_like: Double = 0.0
    var pressure: Int = 0
    var humidity: Int = 0
    
}

struct Sys: Codable {
    var country: String? = ""
}

struct Wind: Codable {
    var speed: Float = 0
    var deg: Int = 0
}

struct WeatherData: Codable {
    var weather: [Weather] = []
    var main: Main = Main()
    var name: String = ""
    var sys: Sys = Sys()
    var wind: Wind = Wind()
    
}

struct List: Codable {
    var main: Main = Main()
    var weather: [Weather] = []
    var wind: Wind = Wind()
    var dt: Int = 0
    var dt_txt: String = ""
}

struct WeatherDataForFiveDays: Codable {
    var message: Int = 0
    var cod: String = ""
   // var cnt: Int = 0
    var list: [List] = []
    
}
