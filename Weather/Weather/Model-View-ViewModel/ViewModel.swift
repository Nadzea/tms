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
    
    private var model: WeatherData? = nil
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
            guard let successModel = self.model else {
                self.didUpdateViewData?(.failure)
                return
            }
            self.didUpdateViewData?(.success(self.giveData(model: successModel), self.updateForecast(weatherDataForFiveDays: self.forecast)))
        }
    }
    
    func giveData(model: WeatherData) -> ViewModel {
        let viewModel = getDate()
        
        viewModel.cityName = "\(model.name ?? "") \(model.sys.country ?? "")"
        
        if let temp = model.main.temp {
            let tempC = Int(round(temp - 273.15))
            viewModel.temperature = "\(tempC)°C"
        }
       
        if let feelTemp = model.main.feels_like {
             let tempFeelLikes = Int(round(feelTemp - 273.15))
            viewModel.feelLikesLabel = "Fell likes \(tempFeelLikes)°C"
        }
        
        model.weather.forEach { value in
            viewModel.weatherIcon = value.icon ?? ""
            viewModel.descriptionLabel = value.description ?? ""
            viewModel.pathVideo = value.id?.typeOfVideo() ?? ""
        }
        
        viewModel.windLabel = model.wind.deg?.typeOfWind() ?? ""
        
        if let speedWind = model.wind.speed {
            viewModel.windLabel += "\(speedWind)m/s"
        }
        
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
        
        for i in 0..<weatherDataForFiveDays.list.count {
            
            guard let today = weatherDataForFiveDays.list[i].dt else { return dataSource}
            
            if today <= Int(dayAfterTommorrow) {
                var icon: String? = nil
                let nextTime = Date(timeIntervalSince1970: TimeInterval(today))
                dateFormater.dateFormat = "HH:mm"
                let time = dateFormater.string(from: nextTime)
                
                var tempC: Int? = nil
                if let temp = weatherDataForFiveDays.list[i].main.temp {
                    tempC = Int(round(temp - 273.15))
                }
                
                let weather = weatherDataForFiveDays.list[i].weather
                weather.forEach { value in
                    icon = value.icon ?? ""
                }
                let todayWeather = TodayWeather(time: time, imageName: icon, temp: tempC)
                dataSource.append(todayWeather)
            }
        }
        
        return dataSource
    }
    
}
