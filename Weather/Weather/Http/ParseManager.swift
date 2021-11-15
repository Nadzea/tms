//
//  ParseManager.swift
//  Weather
//
//  Created by Надежда Клименко on 19.09.21.
//

import UIKit
import SwiftyJSON

class ParseManager {
    static let shared = ParseManager()
    
    func parseWeatherData(_ data: Data) -> WeatherData? {
        var weatherData = WeatherData()
        
        guard let json = try? JSON(data: data), json["cod"].intValue == 200 else { return nil}
        
        var massWeather: [Weather] = []
        var main: Main = Main()
        var sys: Sys = Sys()
        var wind: Wind = Wind()
        let weather = json["weather"]
        var name: String? = nil
        
        for i in weather {
            let j = i.1
            massWeather.append(Weather(id: j["id"].int ?? nil,
                                       main: j["main"].string ?? nil,
                                       description: j["description"].string ?? nil,
                                       icon: j["icon"].string ?? nil))
        }
        
        main = Main(temp: json["main"]["temp"].double ?? nil,
                    feels_like: json["main"]["feels_like"].double ?? nil,
                    pressure: json["main"]["pressure"].int ?? nil,
                    humidity: json["main"]["humidity"].int ?? nil)
        
        name = json["name"].string ?? nil
        sys = Sys(country: json["sys"]["country"].string ?? nil )
        
        wind = Wind(speed: json["wind"]["speed"].float ?? nil,
                    deg: json["wind"]["deg"].int ?? nil)
        
        weatherData = WeatherData(weather: massWeather, main: main, name: name, sys: sys, wind: wind)
        
        return weatherData
    }
    
    func parseWeatherDataForFiveDays(_ data: Data) -> WeatherDataForFiveDays {
        var weatherDataForFiveDays = WeatherDataForFiveDays()
        
        guard let json = try? JSON(data: data), json["cod"].intValue != 404 else { return WeatherDataForFiveDays()}
        
        var massList: [List] = []
        let list = json["list"]
        
        for i in 0..<list.count {
            let weather = list[i]["weather"]
            var massWeather: [Weather] = []
            var main: Main = Main()
            var wind: Wind = Wind()
            var dt: Int? = nil
            var dt_txt: String? = nil
            
            main = Main(temp: list[i]["main"]["temp"].double ?? nil,
                        feels_like: list[i]["main"]["feels_like"].double ?? nil,
                        pressure: list[i]["main"]["pressure"].int ?? nil,
                        humidity: list[i]["main"]["humidity"].int ?? nil)
            
            for i in weather {
                let j = i.1
                massWeather.append(Weather(id: j["id"].int ?? nil,
                                           main: j["main"].string ?? nil,
                                           description: j["description"].string ?? nil,
                                           icon: j["icon"].string ?? nil))
            }
            
            wind = Wind(speed: list[i]["wind"]["speed"].float ?? nil,
                        deg: list[i]["wind"]["deg"].int ?? nil)
            dt = list[i]["dt"].int ?? nil
            dt_txt = list[i]["dt_txt"].string ?? nil
            
            massList.append(List(main: main, weather: massWeather, wind: wind, dt: dt, dt_txt: dt_txt))
        }
        
        weatherDataForFiveDays = WeatherDataForFiveDays(list: massList)
        
        return weatherDataForFiveDays
    }
    
    func parseNews(_ data: Data) -> News {
        var news = News()
        
        guard let json = try? JSON(data: data) else { return News()}
        
        var massArticles: [Articles] = []
        let articles = json["articles"]
        
        for i in 0..<articles.count {
            var article = Articles()
            article = Articles(title: articles[i]["title"].string ?? "",
                               description: articles[i]["description"].string ?? "",
                               url: articles[i]["url"].string ?? "")
            massArticles.append(article)
        }
        news = News(articles: massArticles)
        
        return news
    }
}

