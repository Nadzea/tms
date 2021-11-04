//
//  ModelVVM.swift
//  Weather
//
//  Created by Надежда Клименко on 29.10.21.
//

import UIKit

enum ViewData {
    case initial
    case success(ViewModel, [TodayWeather])
    case failure
}

struct WeatherData: Codable {
    var weather: [Weather] = []
    var main: Main = Main()
    var name: String = ""
    var sys: Sys = Sys()
    var wind: Wind = Wind()
    
}
