//
//  TabBarViewController.swift
//  Weather
//
//  Created by Надежда Клименко on 7.10.21.
//

import UIKit
import UserNotifications
//import CoreLocation

class TabBarViewController: UITabBarController {
    
    //let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 15.0, *) {
           let appearance = UITabBarAppearance()
           appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .black
           
           self.tabBar.standardAppearance = appearance
            //self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance
        }
        
        UIApplication.shared.applicationIconBadgeNumber = 0 //чтобы убирался badge
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.removeAllDeliveredNotifications() // удаляет нотификации которые уже пришли с главного экрана телефона
        
        notificationCenter.getPendingNotificationRequests { request in
            notificationCenter.removePendingNotificationRequests(withIdentifiers: ["5days_notification"])
            print("delete")
        }
        
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { result, error in
            guard result else { return }
            
            let content = UNMutableNotificationContent()
            content.title = "Weather"
            content.sound = UNNotificationSound.default
            content.badge = 1
            content.body = "Hello) Find out what's going on in the world"
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 432000, repeats: false)
            let request = UNNotificationRequest(identifier: "5days_notification", content: content, trigger: trigger)  
            notificationCenter.add(request) { error in
                print(error?.localizedDescription ?? "")
            }
            print("add")
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        setupLocation { result in
//            guard result else { return }
//            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest //задаем точность
//            self.locationManager.delegate = self
//            self.locationManager.startUpdatingLocation()
//        }
//    }
//
//    func setupLocation(_ completion: (Bool) ->()) {    //проверяем включена ли геолокация на телефоне
//        guard CLLocationManager.locationServicesEnabled() else {
//            completion(false)
//            return
//        }
//
//        switch locationManager.authorizationStatus {
//        case .authorizedAlways, .authorizedWhenInUse:
//            completion(true)
//        case .denied:
//            completion(false)
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        default: break
//        }
//    }
//
}
//extension TabBarViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let coordinate = locations.first?.coordinate else { return }
//        print(coordinate.latitude)
//    }
//}
