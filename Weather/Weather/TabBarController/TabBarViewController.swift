//
//  TabBarViewController.swift
//  Weather
//
//  Created by Надежда Клименко on 7.10.21.
//

import UIKit
import UserNotifications

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        RCManager.shared.remoteConfigConnected = {
//            
//        }
//        
//        RCManager.shared.connected()
//        
//        let tabBarController = UITabBarController()
//        
//        guard let vc1 = UIViewController.getViewController(by: "EnterTheCityViewController"),
//              let vc2 = UIViewController.getViewController(by: "MapViewController1"),
//              let vc3 = UIViewController.getViewController(by: "MapViewController") else { return }
//        
//        if RCManager.shared.getBoolValue(from: .useGoogleMaps) {
//            
//            tabBarController.viewControllers = [vc1, vc2]
//            //tabBarController.selectedViewController = vc2
//            self.view.addSubview(tabBarController.view)
//        }else {
//            tabBarController.viewControllers = [vc1, vc3]
//            tabBarController.selectedViewController = vc3
//        }

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
            content.userInfo = ["current" : "WeatherInMyLocationViewController"]
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
            let request = UNNotificationRequest(identifier: "5days_notification", content: content, trigger: trigger)  
            notificationCenter.add(request) { error in
                print(error?.localizedDescription ?? "")
            }
            print("add")
        }
    }
}

