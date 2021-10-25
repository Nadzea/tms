//
//  HttpManager.swift
//  Weather
//
//  Created by Надежда Клименко on 19.09.21.
//

import UIKit
import Alamofire

class HttpManager {
    static let shared = HttpManager()
    
    func getWeatherData(_ URL: String, onCompletion: @escaping (WeatherData) -> Void) {
        AF.request(URL, method: .get).response(queue: DispatchQueue.global(qos: .userInteractive)) { response in
            guard (response.response?.statusCode) != 404 else { return }
            guard let data = response.data else { return }
            onCompletion(ParseManager.shared.parseWeatherData(data))
        }
    }
    
    func getWeatherDataFofFiveDays(_ URL: String, onCompletion: @escaping (WeatherDataForFiveDays) -> Void) {
        AF.request(URL, method: .get).response(queue: DispatchQueue.global(qos: .userInteractive)) { response in
            guard (response.response?.statusCode) != 404 else { return }
            guard let data = response.data else { return }
            onCompletion(ParseManager.shared.parseWeatherDataForFiveDays(data))
        }
    }
    
    func getNews(_ URL: String, onCompletion: @escaping (News) -> Void) {
        AF.request(URL, method: .get).response(queue: DispatchQueue.global(qos: .userInteractive)) { response in
            guard let data = response.data else { return }
            onCompletion(ParseManager.shared.parseNews(data))
        }
    }

    
    
}
