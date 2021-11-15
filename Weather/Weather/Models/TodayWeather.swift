//
//  TodayWeather.swift
//  Weather
//
//  Created by Надежда Клименко on 16.10.21.
//

import UIKit

class TodayWeather {
    let time: String?
    let imageName: String?
    let temp: Int?
    
    init(time: String?, imageName: String?, temp: Int?) {
        self.time = time
        self.imageName = imageName
        self.temp = temp
    }
}
