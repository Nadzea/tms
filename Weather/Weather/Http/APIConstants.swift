//
//  APIConstants.swift
//  Weather
//
//  Created by Надежда Клименко on 19.09.21.
//

import UIKit

enum APIConstants: String {
    case getWeatherData = "http://api.openweathermap.org/data/2.5/weather?lat=52.0495&lon=29.2456&appid=962975e9fd4475a132f0aec7c81f4927"
    
    case newsOfRussia = "https://newsapi.org/v2/top-headlines?sources=google-news-ru&apiKey=1bea36459bff49a88d295fd14ba11634"
    
    case newsOfUSA = "https://newsapi.org/v2/top-headlines?country=us&apiKey=1bea36459bff49a88d295fd14ba11634"
    
    case newsAboutBitcoin = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=1bea36459bff49a88d295fd14ba11634"
}
