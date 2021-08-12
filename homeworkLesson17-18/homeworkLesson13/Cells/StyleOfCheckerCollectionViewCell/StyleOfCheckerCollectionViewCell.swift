//
//  StyleOfCheckerCollectionViewCell.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 11.08.21.
//

import UIKit

class StyleOfCheckerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var whiteChecker: UIImageView!
    @IBOutlet weak var blackChecker: UIImageView!
    @IBOutlet weak var checkerSwitch: UISwitch!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setData(with value:(white: UIImage, black: UIImage)) {
        whiteChecker.image = value.white
        blackChecker.image = value.black
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        whiteChecker.image = nil
        blackChecker.image = nil
    }
    func saveStateSwitchToUserDefaults() {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(self.checkerSwitch, forKey: "stateCheckerSwitch")
    }
    
    func applyStateSwitchToUserDefaults() {
        let userDefaults = UserDefaults.standard
        self.checkerSwitch.isOn = userDefaults.bool(forKey: "stateCheckerSwitch")
    }
    

}
