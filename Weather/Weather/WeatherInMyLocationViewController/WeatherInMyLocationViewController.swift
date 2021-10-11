//
//  WeatherInMyLocationViewController.swift
//  Weather
//
//  Created by Надежда Клименко on 11.10.21.
//

import UIKit
import CoreLocation

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
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        print(latitude)
    }
    
    @IBAction func backScreen(_ senser: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }

}
