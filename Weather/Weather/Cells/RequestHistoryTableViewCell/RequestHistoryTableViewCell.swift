//
//  RequestHistoryTableViewCell.swift
//  Weather
//
//  Created by Надежда Клименко on 9.10.21.
//

import UIKit

class RequestHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setData(with request: Request) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.yy"
        self.dateLabel.text = dateFormater.string(from: request.dateOfRequest)
        self.cityLabel.text = request.cityName
        self.tempLabel.text = "\(String(request.temperature))°C, feel likes \(String(request.tempFeelLikes))°C"
        self.descriptionLabel.text = request.descriptionLabel
        self.windLabel.text = request.wind
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dateLabel.text = ""
        cityLabel.text = ""
        tempLabel.text = ""
        descriptionLabel.text = ""
        windLabel.text = ""
    }
    
    
}
