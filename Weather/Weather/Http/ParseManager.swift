//
//  ParseManager.swift
//  Weather
//
//  Created by Надежда Клименко on 19.09.21.
//

import UIKit

class ParseManager {
    static let shared = ParseManager()
    
    func parseWeatherData(_ data: Data) -> WeatherData {
        var weatherData = WeatherData()
        weatherData = try! JSONDecoder().decode(WeatherData.self, from: data)
        return weatherData
    }
    
    func parseWeatherDataForFiveDays(_ data: Data) -> WeatherDataForFiveDays {
        var weatherDataForFiveDays = WeatherDataForFiveDays()
        weatherDataForFiveDays = try! JSONDecoder().decode(WeatherDataForFiveDays.self, from: data)
        return weatherDataForFiveDays
    }
    
    func parseNews(_ data: Data) -> News {
        var news = News()
        news = try! JSONDecoder().decode(News.self, from: data)
        return news
    }
    
    
}

