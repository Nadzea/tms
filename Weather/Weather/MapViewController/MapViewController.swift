//
//  MapViewController.swift
//  Weather
//
//  Created by Надежда Клименко on 2.10.21.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var feelLikesLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    var weatherData = WeatherData() {
        didSet {
            DispatchQueue.main.async {
                print(self.weatherData)
                self.updateView(weatherData: self.weatherData)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(foundTap(_:)))
        tapGesture.delegate = self
        mapView.addGestureRecognizer(tapGesture)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setupLocation { result in
            guard result else { return }
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest //задаем точность
            self.locationManager.delegate = self
            self.locationManager.startUpdatingLocation()
        }
        
        infoView.center.x -= view.bounds.width
    }
    
    func setupLocation(_ completion: (Bool) ->()) {    //проверяем включена ли геолокация на телефоне
        guard CLLocationManager.locationServicesEnabled() else {
            completion(false)
            return
        }
        
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            completion(true)
        case .denied:
            completion(false)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default: break
        }
    }
    
    func updateView(weatherData: WeatherData) {
        
        descriptionLabel.text = weatherData.weather[0].description
        humidityLabel.text = "Humidity \(weatherData.main.humidity)%"
        let tempC = Int(round(weatherData.main.temp - 273.15))
        temperature.text = "Temperature: \(tempC)°C"
        let tempFeelLikes = Int(round(weatherData.main.feels_like - 273.15))
        feelLikesLabel.text = "Fell likes: \(tempFeelLikes)°C"
        weatherIcon.image = UIImage(named: weatherData.weather[0].icon)
    }
    
    func getAdressAndWeather(getLat: CLLocationDegrees, getLon: CLLocationDegrees) {

        let locationTouch: CLLocation =  CLLocation(latitude: getLat, longitude: getLon)
        
        CLGeocoder().reverseGeocodeLocation(locationTouch, preferredLocale: Locale(identifier: "en")) { placemark, error in
            if let _ = error {
                self.infoLabel.text = "Error..."
            } else {
                guard let place = placemark?.first else { return }
                let info = "\(place.country ?? "") \(place.city ?? "") \(place.streetName ?? "") \(place.streetNumber ?? "")"
                self.infoLabel.text = info
                
                let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(getLat)&lon=\(getLon)&appid=bb3af6a661e716dc3b3bfab4c1c87d6c"
                HttpManager.shared.getWeatherData(url) { weatherData in
                    self.weatherData = weatherData
                }
                UIView.animate(withDuration: 2, delay: 0) {
                    self.infoView.center.x += self.view.bounds.width
                }
            }
        }
    }
    
    @IBAction func closeInfoView(_ sender: Any) {
        UIView.animate(withDuration: 2, delay: 0) {
            self.infoView.center.x -= self.view.bounds.width
        }
    }
    
    @objc func foundTap(_ recognizer: UITapGestureRecognizer) {
        
        let point: CGPoint = recognizer.location(in: mapView)
        print(point)
        let tapPoint: CLLocationCoordinate2D = mapView.convert(point, toCoordinateFrom: view)
        print(tapPoint)
        let point1 = MKPointAnnotation()
        point1.coordinate = tapPoint
        mapView.addAnnotation(point1)
        let getLat: CLLocationDegrees = tapPoint.latitude
        let getLon: CLLocationDegrees = tapPoint.longitude
        
        getAdressAndWeather(getLat: getLat, getLon: getLon)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.first?.coordinate else { return }
        print(coordinate.latitude)
    }
}

extension CLPlacemark {
    /// street name, eg. Infinite Loop
    var streetName: String? { thoroughfare }
    /// // eg. 1
    var streetNumber: String? { subThoroughfare }
    /// city, eg. Cupertino
    var city: String? { locality }
    /// neighborhood, common name, eg. Mission District
    var neighborhood: String? { subLocality }
    /// state, eg. CA
    var state: String? { administrativeArea }
    /// county, eg. Santa Clara
    var county: String? { subAdministrativeArea }
    /// zip code, eg. 95014
    var zipCode: String? { postalCode }
}

