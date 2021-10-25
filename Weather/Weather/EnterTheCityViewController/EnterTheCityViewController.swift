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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.center.x = -120
        
        //locationManager.requestAlwaysAuthorization()
        
        textField.delegate = self
        
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: .main) { _ in
            if self.textField.text != "" {
                self.errorLabel.text = ""
            }
        }
        
        let vc = UIStoryboard(name: "EnterTheCityViewController", bundle: nil).instantiateViewController(withIdentifier: "EnterTheCityViewController")

        guard let newVC = SettingsManager.shared.pushVC,
              let vc2 = UIViewController.getViewController(by: "WeatherInMyLocationViewController") else { return }

        switch newVC {
        case "EnterTheCityViewController":
            navigationController?.setViewControllers([vc], animated: true)
        case "WeatherInMyLocationViewController":
            setupStatus(vc: vc, vc2: vc2)
        default: break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {  //2
        super.viewWillAppear(true)
        
        //menuView.center.x -= self.view.bounds.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        menuView.center.x -= self.view.bounds.width
    }
    
    func setupStatus(vc: UIViewController, vc2: UIViewController) {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            navigationController?.setViewControllers([vc, vc2], animated: true)
        case .denied, .restricted:
            showSettingsAlert()
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
        
        guard let vc = storyboard.instantiateInitialViewController() as? WeatherInfoViewController else { return }
        
        vc.city = cityName
        
        textField.text = ""
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentWeatherInMyLocation() {
        let storyboard = UIStoryboard(name: "WeatherInMyLocationViewController", bundle: nil)
        
        guard let vc = storyboard.instantiateInitialViewController() as? WeatherInMyLocationViewController else { return }
        
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
        menuView.center.x -= self.view.bounds.width
        let storyboard = UIStoryboard(name: "RequestHistoryViewController", bundle: nil)
        
        guard let vc = storyboard.instantiateInitialViewController() as? RequestHistoryViewController else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func presentMenu(_ sender: Any) {
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut) {
            self.menuView.center.x += self.view.bounds.width
        }
    }
    
    @IBAction func closeMenuView(_ sender: Any) {
        UIView.animate(withDuration: 1.5, delay: 0) {
            self.menuView.center.x -= self.view.bounds.width
        }
    }
    
    @IBAction func weatherInMyLocationButton(_ sender: Any) {
        
        locationManager.requestAlwaysAuthorization()
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            presentWeatherInMyLocation()
        case .denied, .restricted:
            showSettingsAlert()
        default: break
        }
    }
}


