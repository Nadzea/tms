//
//  StyleOfCheckerCollectionViewCell.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 11.08.21.
//

import UIKit
protocol StyleOfCheckerCollectionViewCellDelegate: AnyObject {
    func switchDidTap(_ sender: UISwitch)
}

class StyleOfCheckerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var whiteChecker: UIImageView!
    @IBOutlet weak var blackChecker: UIImageView!
    @IBOutlet weak var checkerSwitch: UISwitch!
    
    weak var delegate: StyleOfCheckerCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkerSwitch.onTintColor = UIColor.blue
        checkerSwitch.tintColor = UIColor.green
        checkerSwitch.thumbTintColor = UIColor.orange
    }
    
    func setData(with style: StyleOfChecker) {
        whiteChecker.image = UIImage(named: style.whiteChecker!)
        whiteChecker.contentMode = .scaleAspectFit
        blackChecker.image = UIImage(named: style.blackChecker!)
        checkerSwitch.isOn = style.stateSwitch == true ? true : false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        whiteChecker.image = nil
        blackChecker.image = nil
    }
//    func saveStateSwitchToUserDefaults() {
//        let userDefaults = UserDefaults.standard
//        userDefaults.setValue(self.checkerSwitch.isOn, forKey: "stateCheckerSwitch")
//    }
//
//    func applyStateSwitchToUserDefaults() {
//        let userDefaults = UserDefaults.standard
//        self.checkerSwitch.isOn = userDefaults.bool(forKey: "stateCheckerSwitch")
//    }
    
    @IBAction func switchValueDidChange(_ sender: UISwitch) {
        delegate?.switchDidTap(checkerSwitch)
    }

}
