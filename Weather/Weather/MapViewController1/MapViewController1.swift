//
//  MapViewViewController1.swift
//  Weather
//
//  Created by Надежда Клименко on 18.10.21.
//

import UIKit
import GoogleMaps

class MapViewController1: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var markerImage: UIImageView!
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var feelLikesLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    var weatherData = WeatherData() {
        didSet {
            DispatchQueue.main.async {
                self.updateView(weatherData: self.weatherData)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoView.center.x -= view.bounds.width
        
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
//        let marker = GMSMarker()
//        
//        marker.iconView = markerImage
//        marker.map = mapView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        infoView.center.x -= view.bounds.width
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
        
        if infoView.center.x > 0 {
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.infoView.center.x -= self.view.bounds.width
            }
        }
        
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
                UIView.animate(withDuration: 1, delay: 0) {
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
}

extension MapViewController1: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.infoView.center.x -= self.view.bounds.width
        }
        print("willMove")
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        print("didChange position \(position.target)")
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        print("idleAt \(position.target)")
//        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: position.target.latitude, longitude: position.target.longitude))
//
//        marker.map = mapView
        getAdressAndWeather(getLat: position.target.latitude, getLon: position.target.longitude)
    
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
             marker.map = mapView
        
        getAdressAndWeather(getLat: coordinate.latitude, getLon: coordinate.longitude)
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
