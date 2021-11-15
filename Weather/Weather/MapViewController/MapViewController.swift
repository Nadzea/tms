//
//  MapViewController.swift
//  Weather
//
//  Created by Надежда Клименко on 2.10.21.
//

import UIKit
import MapKit
import GoogleMaps
import RxSwift

class MapViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var feelLikesLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var infoViewLeadingConstraint: NSLayoutConstraint!
    
    let coordinate = BehaviorSubject<CLLocationCoordinate2D>(value: CLLocationCoordinate2D())
    let disposeBag = DisposeBag()
    let anotationCenter = MKPointAnnotation()
    var dispatchItem: DispatchWorkItem?
    
    var weatherData = WeatherData() {
        didSet {
            DispatchQueue.main.async {
                self.updateView(weatherData: self.weatherData)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coordinate
            .debounce(DispatchTimeInterval.seconds(5), scheduler: MainScheduler.instance)
            .subscribe(onNext: { coordinate in
                print(coordinate)
                self.getAdressAndWeather(getLat: self.mapView.centerCoordinate.latitude, getLon: self.mapView.centerCoordinate.longitude)
            })
            .disposed(by: disposeBag)
        
        mapView.showsUserLocation = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(foundTap(_:)))
        tapGesture.delegate = self
        mapView.addGestureRecognizer(tapGesture)
        
        mapView.delegate = self
        anotationCenter.coordinate = mapView.centerCoordinate
        mapView.addAnnotation(anotationCenter)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        infoViewLeadingConstraint.constant = -self.view.bounds.width
    }
    
    func updateView(weatherData: WeatherData) {
        
        descriptionLabel.text = weatherData.weather[0].description ?? ""
        
        if let humidity = weatherData.main.humidity {
            humidityLabel.text = "Humidity \(humidity)%"
        }
       
        if let temp = weatherData.main.temp {
            let tempC = Int(round(temp - 273.15))
            temperature.text = "Temperature: \(tempC)°C"
        }
        
        if let feelTemp = weatherData.main.feels_like {
            let tempFeelLikes = Int(round(feelTemp - 273.15))
            feelLikesLabel.text = "Fell likes \(tempFeelLikes)°C"
        }

        weatherIcon.image = UIImage(named: weatherData.weather[0].icon ?? "")
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
                
                HttpManager.shared.getWeatherData(nil, latitude: getLat, longitude: getLon) { weatherData in
                    guard let successWeatherData = weatherData else { return }
                    self.weatherData = successWeatherData
                }
                UIView.animate(withDuration: 1, delay: 0) {
                    self.infoViewLeadingConstraint.constant = 0
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @IBAction func closeInfoView(_ sender: Any) {
        UIView.animate(withDuration: 2, delay: 0) {
            self.infoViewLeadingConstraint.constant = -self.view.bounds.width
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func foundTap(_ recognizer: UITapGestureRecognizer) {
        if infoViewLeadingConstraint.constant == 0 {
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.infoViewLeadingConstraint.constant = -self.view.bounds.width
                self.view.layoutIfNeeded()
            }
        }
        
        let point: CGPoint = recognizer.location(in: mapView)
        print(point)
        let tapPoint: CLLocationCoordinate2D = mapView.convert(point, toCoordinateFrom: mapView)
        print(tapPoint)
        let point1 = MKPointAnnotation()
        point1.coordinate = tapPoint
        mapView.addAnnotation(point1)
        let getLat: CLLocationDegrees = tapPoint.latitude
        let getLon: CLLocationDegrees = tapPoint.longitude
        
        getAdressAndWeather(getLat: getLat, getLon: getLon)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        
        if infoViewLeadingConstraint.constant == 0 {
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.infoViewLeadingConstraint.constant = -self.view.bounds.width
                self.view.layoutIfNeeded()
            }
        }
        anotationCenter.coordinate = mapView.centerCoordinate
        
        coordinate.onNext(mapView.centerCoordinate)
        
    }
}


