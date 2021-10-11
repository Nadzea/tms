//
//  WeatherInfoViewController.swift
//  Weather
//
//  Created by Надежда Клименко on 21.09.21.
//

import UIKit
import AVFoundation

class WeatherInfoViewController: UIViewController {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var feelLikesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    
    var date = Date()
    let dateFormater = DateFormatter()
    var player: AVPlayer?
    
    var city: String = ""
    
    var weatherData = WeatherData() {
        didSet {
            DispatchQueue.main.async {
                self.updateView(self.weatherData)
            }
        }
    }
    
    var weatherDataForFiveDays = WeatherDataForFiveDays() {
        didSet {
            DispatchQueue.main.async {
                self.updateForecast()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=bb3af6a661e716dc3b3bfab4c1c87d6c"
        let urlForFiveDays = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=bb3af6a661e716dc3b3bfab4c1c87d6c"
        
        HttpManager.shared.getWeatherData(url) { weatherData in
            
            self.weatherData = weatherData
        }
        
        if weatherData.name == "" {
            cityName.text = "City not found"
        }
        
        HttpManager.shared.getWeatherDataFofFiveDays(urlForFiveDays) { weatherDataForFiveDays in
            self.weatherDataForFiveDays = weatherDataForFiveDays
        }
        
        getDate()
        
    }
    
    func getDate() {
        dateFormater.dateFormat = "dd MMM. yy"
        let today = dateFormater.string(from: date)
        print(date)
        dateFormater.dateFormat = "EEE"
        let dayOfWeek = dateFormater.string(from: date).capitalized
        dateLabel.text = "\(dayOfWeek) \(today) "
        dateFormater.dateFormat = "HH:mm"
        timeLabel.text = dateFormater.string(from: date)
        
    }
    
    func playVideo(_ pathVideo: String?) {
        guard let pathVideo = pathVideo else { return }
        NotificationCenter.default.removeObserver(self)
        let urlVideo = URL(fileURLWithPath: pathVideo)
        let asset = AVAsset(url: urlVideo)
        let playItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playItem)
        self.player = player
        let videoLayer = AVPlayerLayer(player: player)
        videoLayer.frame = CGRect(origin: .zero, size: videoView.frame.size)
        videoLayer.videoGravity = .resizeAspectFill
        videoView.layer.insertSublayer(videoLayer, at: 0)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playItem, queue: .main) { _ in
            self.player?.seek(to: .zero)
            self.player?.play()
        }
        player.play()
    }
    
        
    func updateView(_ weatherData: WeatherData) {
        
        self.cityName.text = "\(weatherData.name), \(weatherData.sys.country)"
        
        self.descriptionLabel.text = weatherData.weather[0].description
        let tempC = Int(round(weatherData.main.temp - 273.15))
        self.temperature.text = "\(tempC)°C"
        let tempFeelLikes = Int(round(weatherData.main.feels_like - 273.15))
        self.feelLikesLabel.text = "Fell likes \(tempFeelLikes)°C"
        self.weatherIcon.image = UIImage(named: weatherData.weather[0].icon)
        
        
        switch weatherData.wind.deg {
        case 0...11, 349...360:
            self.windLabel.text = "Wind: north \(weatherData.wind.speed)m/s"
        case 12...78:
            self.windLabel.text = "Wind: northeast \(weatherData.wind.speed)m/s"
        case 79...101:
            self.windLabel.text = "Wind: east \(weatherData.wind.speed)m/s"
        case 102...168:
            self.windLabel.text = "Wind: southeast \(weatherData.wind.speed)m/s"
        case 169...191:
            self.windLabel.text = "Wind: south \(weatherData.wind.speed)m/s"
        case 192...258:
            self.windLabel.text = "Wind: southwest \(weatherData.wind.speed)m/s"
        case 259...281:
            self.windLabel.text = "Wind: west \(weatherData.wind.speed)m/s"
        case 282...348:
            self.windLabel.text = "Wind: northwest \(weatherData.wind.speed)m/s"
        default:
            self.windLabel.text = ""
        }
        
        switch weatherData.weather[0].id {
        case 200, 201, 210, 211, 230, 231:
            let pathVideo = Bundle.main.path(forResource: "thunderstorm", ofType: "mp4")
            self.playVideo(pathVideo)
        case 202, 232:
            let pathVideo = Bundle.main.path(forResource: "thunderstormWithRain", ofType: "mp4")
            self.playVideo(pathVideo)
        case 212, 221:
            let pathVideo = Bundle.main.path(forResource: "heavyThunderstorm", ofType: "mp4")
            self.playVideo(pathVideo)
        case 501, 521, 531:
            let pathVideo = Bundle.main.path(forResource: "rain", ofType: "mp4")
            self.playVideo(pathVideo)
        case 503, 502, 520, 522:
            let pathVideo = Bundle.main.path(forResource: "veryHeavyRain", ofType: "mp4")
            self.playVideo(pathVideo)
        case 500:
            let pathVideo = Bundle.main.path(forResource: "lightRain", ofType: "mp4")
            self.playVideo(pathVideo)
        case 800:
            let pathVideo = Bundle.main.path(forResource: "clearSky", ofType: "mp4")
            self.playVideo(pathVideo)
        case 801:
            let pathVideo = Bundle.main.path(forResource: "fewClouds 2", ofType: "mp4")
            self.playVideo(pathVideo)
        case 802:
            let pathVideo = Bundle.main.path(forResource: "scatteredСlouds", ofType: "mp4")
            self.playVideo(pathVideo)
        case 803:
            let pathVideo = Bundle.main.path(forResource: "brokenСlouds", ofType: "mp4")
            self.playVideo(pathVideo)
        case 804:
            let pathVideo = Bundle.main.path(forResource: "overcastClouds", ofType: "mp4")
            self.playVideo(pathVideo)
            
        default: break
        }
        
    }
    
    func updateForecast() {
        let dateFormater = DateFormatter()
        //dateFormater.dateFormat = "dd.MM.yy"
        var tempMin: Double = 0
        var tempMax: Double = 0
        var dateSting: String = ""
        var dayOfWeek: String = ""
        for i in 0...8 {
            print(weatherDataForFiveDays.list[0].weather[0].icon)
            let date = dateFormater.date(from: weatherDataForFiveDays.list[0].dt_txt) ?? Date()
            dateFormater.dateFormat = "dd.MM.yy"
            dateSting = dateFormater.string(from: date)
            dateFormater.dateFormat = "EEE"
            dayOfWeek = dateFormater.string(from: date).capitalized
            tempMin = weatherDataForFiveDays.list[0].main.temp
            tempMax = weatherDataForFiveDays.list[0].main.temp
            if weatherDataForFiveDays.list[i].main.temp < tempMin {
                tempMin = weatherDataForFiveDays.list[i].main.temp
            }
            if weatherDataForFiveDays.list[i].main.temp > tempMax {
                tempMax = weatherDataForFiveDays.list[i].main.temp
            }
        }
        print(dateSting)
        print(dayOfWeek)
        print(tempMin)
        print(tempMax)
        
    }
    
    @IBAction func backScreen(_ senser: Any) {
        if weatherData.name != "" {
            RealmManager.shared.createRequest(weatherData: weatherData, date: date)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
