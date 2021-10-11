//
//  ViewController.swift
//  Weather
//
//  Created by Надежда Клименко on 5.09.21.
//

import UIKit
import CoreLocation

class EnterTheCityViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var menuView: UIView!
    
    let locationManager = CLLocationManager()
    var lat: Double = 0.0
    var lon: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: .main) { _ in
            if self.textField.text != "" {
                self.errorLabel.text = ""
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        menuView.center.x -= self.view.bounds.width
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        menuView.center.x -= self.view.bounds.width
    }
    
    func setupLocation(_ completion: (Bool) ->()) {    //проверяем включена ли геолокация на телефоне
        guard CLLocationManager.locationServicesEnabled() else {
            completion(false)
            return
        }
        
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            completion(true)
        case .denied, .restricted:
            showSettingsAlert()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default: break
        }
    }
    
    func showSettingsAlert() {
        let alert = UIAlertController(title: nil, message: "Your need allow use location in app settings", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let setting = UIAlertAction(title: "Settings", style: .default) { _ in
            
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(setting)
        
        present(alert, animated: true, completion: nil)
    }
    
    func presentWeatherInfoScreen() {
        guard let cityName = textField.text, !cityName.isEmpty else {
            errorLabel.text = "You haven't entered the city"
            return
        }
        let storyboard = UIStoryboard(name: "WeatherInfoViewController", bundle: nil)
        
        guard let vc = storyboard.instantiateInitialViewController() as? WeatherInfoViewController else {
            return
        }
        
        vc.city = cityName
        
        textField.text = ""
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentWeatherInMyLocation() {
        let storyboard = UIStoryboard(name: "WeatherInMyLocationViewController", bundle: nil)
        
        guard let vc = storyboard.instantiateInitialViewController() as? WeatherInMyLocationViewController else {
            return
        }
        
        vc.latitude = lat
        vc.longitude = lon
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.first) != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    } //чтобы клавиатура скрывалась, еси пользователь нажимает зп пределами текстфилда
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        presentWeatherInfoScreen()
        
        textField.resignFirstResponder()
            
        return true
    }
    
    @IBAction func presentWeatherScreen(_ sender: Any) {
        presentWeatherInfoScreen()
    }
    
    @IBAction func presentRequestHistory(_ sender: Any) {
        let storyboard = UIStoryboard(name: "RequestHistoryViewController", bundle: nil)
        
        guard let vc = storyboard.instantiateInitialViewController() as? RequestHistoryViewController else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
//        let currentStoryboard = UIStoryboard(name: "RequestHistoryViewController", bundle: nil)
//        let currentViewController = currentStoryboard.instantiateInitialViewController() as! RequestHistoryViewController
//        currentViewController.modalPresentationStyle = .fullScreen
//        currentViewController.modalTransitionStyle = .crossDissolve
//        present(currentViewController, animated: true, completion: nil)
    }
    
    @IBAction func presentMenu(_ sender: Any) {
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut) {
            self.menuView.center.x += self.view.bounds.width
        }
    }
    
    @IBAction func closeMenuView(_ sender: Any) {
        UIView.animate(withDuration: 2, delay: 0) {
            self.menuView.center.x -= self.view.bounds.width
        }
    }
    
    @IBAction func weatherInMyLocationButton(_ sender: Any) {
        setupLocation { result in
            guard result else { return }
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest //задаем точность
            self.locationManager.delegate = self
            self.locationManager.startUpdatingLocation()
            presentWeatherInMyLocation()
        }
        
        
//        let currentStoryboard = UIStoryboard(name: "WeatherInMyLocationViewController", bundle: nil)
//        let currentViewController = currentStoryboard.instantiateInitialViewController() as! WeatherInMyLocationViewController
//        currentViewController.modalPresentationStyle = .fullScreen
//        currentViewController.modalTransitionStyle = .crossDissolve
//        present(currentViewController, animated: true, completion: nil)
        
    }
    
}

extension EnterTheCityViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.first?.coordinate else { return }
        
        lat = coordinate.latitude
        lon = coordinate.longitude
        
    }
}

