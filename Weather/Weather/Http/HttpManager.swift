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
    
    func getWeatherData(_ city: String?, latitude: Double?, longitude: Double?, onCompletion: @escaping (WeatherData) -> Void) {
        
        let url = city != "" ? "https://api.openweathermap.org/data/2.5/weather?q=\(city ?? "")&appid=bb3af6a661e716dc3b3bfab4c1c87d6c" : "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude ?? 0)&lon=\(longitude ?? 0)&appid=bb3af6a661e716dc3b3bfab4c1c87d6c"

        AF.request(url, method: .get).response(queue: DispatchQueue.global(qos: .userInteractive)) { response in
            guard (response.response?.statusCode) != 404 else { return }
            guard let data = response.data else { return }
            onCompletion(ParseManager.shared.parseWeatherData(data))
        }
    }
    
    func getWeatherDataFofFiveDays(_ city: String?, latitude: Double?, longitude: Double?, onCompletion: @escaping (WeatherDataForFiveDays) -> Void) {
        
        let urlForFiveDays = city != "" ? "https://api.openweathermap.org/data/2.5/forecast?q=\(city ?? "")&appid=bb3af6a661e716dc3b3bfab4c1c87d6c" : "http://api.openweathermap.org/data/2.5/forecast?lat=\(latitude ?? 0)&lon=\(longitude ?? 0)&appid=bb3af6a661e716dc3b3bfab4c1c87d6c"
        
        AF.request(urlForFiveDays, method: .get).response(queue: DispatchQueue.global(qos: .userInteractive)) { response in
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
