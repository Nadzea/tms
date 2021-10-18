//
//  WeatherInMyLocationViewController.swift
//  Weather
//
//  Created by Надежда Клименко on 11.10.21.
//

import UIKit
import CoreLocation
import AVFoundation

class WeatherInMyLocationViewController: UIViewController {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var feelLikesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let locationManager = CLLocationManager()
    var player: AVPlayer?
    var date = Date()
    let dateFormater = DateFormatter()
    var dayAfterTommorrow: Double = 0
    var dataSource: [TodayWeather] = []
    
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
                self.setupCollectionView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.layer.cornerRadius = 30
        
        SettingsManager.shared.pushVC = nil
        getDate()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //задаем точность
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
    }
    
    func getDate() {
        dateFormater.dateFormat = "dd MMM. yy"
        let today = dateFormater.string(from: date)
        
        let calendar = Calendar.current
        let currentdate = calendar.dateComponents(in: .current, from: date)
        
        let time = (currentdate.second ?? 0) + (currentdate.minute ?? 0) * 60 + (currentdate.hour ?? 0) * 60 * 60
        dayAfterTommorrow = date.timeIntervalSince1970 + Double((86400 - time)) + 86400
        
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
        
        windLabel.text = weatherData.wind.deg.typeOfWind() + "\(weatherData.wind.speed)m/s"
        
        playVideo(weatherData.weather[0].id.typeOfVideo())
        
    }
    
    func updateForecast() {
        
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
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "TodayWeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TodayWeatherCollectionViewCell")
    }
    
    @IBAction func backScreen(_ senser: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension WeatherInMyLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.first?.coordinate else { return }
        
        let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=bb3af6a661e716dc3b3bfab4c1c87d6c"
        let urlForFiveDays = "http://api.openweathermap.org/data/2.5/forecast?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=bb3af6a661e716dc3b3bfab4c1c87d6c"
        
        HttpManager.shared.getWeatherData(url) { weatherData in
            
            self.weatherData = weatherData
        }
        
        HttpManager.shared.getWeatherDataFofFiveDays(urlForFiveDays) { weatherDataForFiveDays in
            self.weatherDataForFiveDays = weatherDataForFiveDays
        }
    }
}
extension WeatherInMyLocationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayWeatherCollectionViewCell", for: indexPath) as? TodayWeatherCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setData(with: dataSource[indexPath.item])
        
        return cell
    }
}

extension WeatherInMyLocationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 130)
    }
}

