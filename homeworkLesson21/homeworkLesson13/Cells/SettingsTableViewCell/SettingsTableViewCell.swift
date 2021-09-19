//
//  SettingsTableViewCell.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 14.09.21.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var forwardImage: UIImageView!
    @IBOutlet weak var typeOfSettings: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.typeOfSettings.text = ""
    }

    func setup(with typeOfSettings: Settings) {
        self.typeOfSettings.text = typeOfSettings.type
    }
    
    func addFont() {
        typeOfSettings.addAttributedText(with: .black, foregroundColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), strokeWidth: -2, size: 40)
    }
    
    func addLavanderiaFont() {
        typeOfSettings.addAttributedTextWithLavanderiaScript(with: .black, foregroundColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), strokeWidth: -2, size: 40)
    }
    
}
