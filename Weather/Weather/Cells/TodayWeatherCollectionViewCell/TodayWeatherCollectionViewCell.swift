//
//  TodayWeatherCollectionViewCell.swift
//  Weather
//
//  Created by Надежда Клименко on 16.10.21.
//

import UIKit

class TodayWeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setData(with todayWeather: TodayWeather) {
        timeLabel.text = todayWeather.time
        weatherIcon.image = UIImage(named: todayWeather.imageName ?? "")
        guard let temp = todayWeather.temp else { return }
        tempLabel.text = "\(temp)°C"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        timeLabel.text = ""
        weatherIcon.image = nil
        tempLabel.text = ""
    }
    

}
