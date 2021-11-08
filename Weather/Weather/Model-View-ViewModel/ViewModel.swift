//
//  ViewModel.swift
//  Weather
//
//  Created by Надежда Клименко on 27.10.21.
//

import UIKit

protocol ViewModelProtocol: AnyObject {
    var didUpdateViewData: ((ViewData) -> ())? { get set }
    func getData(city: String?, latitude: Double?, longitude: Double?)
}

class ViewModel: ViewModelProtocol {
    var cityName: String = ""
    var temperature: String = ""
    var weatherIcon: String = ""
    var descriptionLabel: String = ""
    var feelLikesLabel: String = ""
    var dateLabel: String = ""
    var timeLabel: String = ""
    var windLabel: String = ""
    var pathVideo: String = ""
    
    public var didUpdateViewData: ((ViewData) -> ())?
    
    init(cityName: String, temperature: String, weatherIcon: String, descriptionLabel: String, feelLikesLabel: String, windLabel: String, pathVideo: String) {
        self.cityName = cityName
        self.temperature = temperature
        self.weatherIcon = weatherIcon
        self.descriptionLabel = descriptionLabel
        self.feelLikesLabel = feelLikesLabel
        self.windLabel = windLabel
        self.pathVideo = pathVideo
        
    }
    
    private var model = WeatherData()
    private var forecast = WeatherDataForFiveDays()
    
    init() {
        didUpdateViewData?(.initial)
    }
    
    weak private var view: WeatherInfoViewController?
    weak private var viewMyLocation: WeatherInMyLocationViewController?
    
    deinit {
        didUpdateViewData = nil
    }
    
    init(view: WeatherInfoViewController) {
        self.view = view
    }
    
    init(view: WeatherInMyLocationViewController) {
        self.viewMyLocation = view
    }
    
    func getData(city: String?, latitude: Double?, longitude: Double? ) {
        
        let group = DispatchGroup()
        
        group.enter()
        HttpManager.shared.getWeatherData(city, latitude: latitude, longitude: longitude) { weatherData in
            self.model = weatherData
            group.leave()
        }
        
        group.enter()
        HttpManager.shared.getWeatherDataFofFiveDays(city, latitude: latitude, longitude: longitude) { weatherDataForFiveDays in
            self.forecast = weatherDataForFiveDays
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.didUpdateViewData?(.success(self.giveData(model: self.model), self.updateForecast(weatherDataForFiveDays: self.forecast)))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if self.model.name == ""{
                self.didUpdateViewData?(.failure)
            }
        }
    }
    
    func giveData(model: WeatherData) -> ViewModel {
        let viewModel = getDate()
        
        viewModel.cityName = "\(model.name), \(model.sys.country ?? "")"
        
        viewModel.descriptionLabel = model.weather[0].description
        let tempC = Int(round(model.main.temp - 273.15))
        viewModel.temperature = "\(tempC)°C"
        let tempFeelLikes = Int(round(model.main.feels_like - 273.15))
        viewModel.feelLikesLabel = "Fell likes \(tempFeelLikes)°C"
        viewModel.weatherIcon = model.weather[0].icon
        
        viewModel.windLabel = model.wind.deg.typeOfWind() + "\(model.wind.speed)m/s"
        viewModel.pathVideo = model.weather[0].id.typeOfVideo()
        
        return viewModel
    }
    
    func getDate() -> ViewModel {
        let viewModel = ViewModel()
        let date = Date()
        let dateFormater = DateFormatter()
        
        dateFormater.dateFormat = "dd MMM. yy"
        let today = dateFormater.string(from: date)
        
        dateFormater.dateFormat = "EEE"
        let dayOfWeek = dateFormater.string(from: date).capitalized
        viewModel.dateLabel = "\(dayOfWeek) \(today) "
        dateFormater.dateFormat = "HH:mm"
        viewModel.timeLabel = dateFormater.string(from: date)
        return viewModel
    }
    
    func nextDay() -> Double {
        let date = Date()
        var dayAfterTommorrow: Double = 0
        let calendar = Calendar.current
        let currentdate = calendar.dateComponents(in: .current, from: date)
        
        let time = (currentdate.second ?? 0) + (currentdate.minute ?? 0) * 60 + (currentdate.hour ?? 0) * 60 * 60
        dayAfterTommorrow = date.timeIntervalSince1970 + Double((86400 - time)) + 86400
        return dayAfterTommorrow
    }
    
    func updateForecast(weatherDataForFiveDays: WeatherDataForFiveDays) -> [TodayWeather] {
        let dayAfterTommorrow = nextDay()
        let dateFormater = DateFormatter()
        var dataSource: [TodayWeather] = []
        
        for i in 0...16 {
            
            if weatherDataForFiveDays.list[i].dt <= Int(dayAfterTommorrow) {
                
                let nextTime = Date(timeIntervalSince1970: TimeInterval(weatherDataForFiveDays.list[i].dt))
                dateFormater.dateFormat = "HH:mm"
                let time = dateFormater.string(from: nextTime)
                let tempC = Int(round(weatherDataForFiveDays.list[i].main.temp - 273.15))
                let todayWeather = TodayWeather(time: time, imageName: weatherDataForFiveDays.list[i].weather[0].icon, temp: tempC)
                dataSource.append(todayWeather)
            }
        }
        return dataSource
    }
    
}
