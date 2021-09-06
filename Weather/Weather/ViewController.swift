//
//  ViewController.swift
//  Weather
//
//  Created by Надежда Клименко on 5.09.21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var feelLikesLabel: UILabel!
    
    
    let locationManager = CLLocationManager()
    var weatherData = WeatherData()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startLocationManager()
        
    }
    
    func startLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() { //если включена геолокация на телефоне
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters //точность 100м
            locationManager.pausesLocationUpdatesAutomatically = true
            locationManager.startUpdatingLocation() //запускается отслеживание местоположения
        }
        
    }
    
    func updateView() {
        cityName.text = "\(weatherData.name), \(weatherData.sys.country)"
        descriptionLabel.text = weatherData.weather[0].description
        let tempC = String(format: "%.1F", weatherData.main.temp - 273.15)
        temperature.text = tempC + "°C"
        let tempFeelLikes = String(format: "%.1F", weatherData.main.feels_like - 273.15)
        feelLikesLabel.text = "Fell likes \(tempFeelLikes)°C"
        weatherIcon.image = UIImage(named: weatherData.weather[0].icon)
        
    }
    
    func updateWeatherInfo(latitude: Double, longitude: Double) {
        let session = URLSession.shared
//        let urlString = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude.description)&lon=\(longitude.description)&appid=962975e9fd4475a132f0aec7c81f4927")!
        let urlString = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=52.0495&lon=29.2456&appid=962975e9fd4475a132f0aec7c81f4927")!
        
        let task = session.dataTask(with: urlString) { data, response, error in
            
            guard error == nil else {
                print("DataTask error: \(error!.localizedDescription)")
                return
            }

            do {
                self.weatherData = try JSONDecoder().decode(WeatherData.self, from: data!)
                print(self.weatherData)
                DispatchQueue.main.async {
                    self.updateView()
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            updateWeatherInfo(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
            print(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude)
        }
    }
}

