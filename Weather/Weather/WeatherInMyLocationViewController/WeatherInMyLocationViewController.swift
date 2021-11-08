//
//  WeatherInMyLocationViewController.swift
//  Weather
//
//  Created by Надежда Клименко on 11.10.21.
//

import UIKit
import CoreLocation

class WeatherInMyLocationViewController: UIViewController {
    
    @IBOutlet weak var testView: TestView!
    
    lazy var viewModel: ViewModel = {
        return ViewModel.init(view: self)
    }()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SettingsManager.shared.pushVC = nil
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //задаем точность
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        updateView()
    }
    
    func updateView() {
        
        viewModel.didUpdateViewData = { viewData in
            
            self.testView.viewData = viewData
        }
    }
    
    @IBAction func backScreen(_ senser: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension WeatherInMyLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.first?.coordinate else { return }
        
        viewModel.getData(city: nil, latitude: coordinate.latitude, longitude: coordinate.longitude)
        
    }
}

