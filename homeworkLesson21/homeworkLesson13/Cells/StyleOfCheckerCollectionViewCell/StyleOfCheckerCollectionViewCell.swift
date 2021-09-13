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
        checkerSwitch.onTintColor = .black
        checkerSwitch.thumbTintColor = .white
    }
    
    func setData(with style: StyleOfChecker) {
        whiteChecker.image = UIImage(named: style.whiteChecker!)
        blackChecker.image = UIImage(named: style.blackChecker!)
        checkerSwitch.setOn(style.stateSwitch, animated: true)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        whiteChecker.image = nil
        blackChecker.image = nil
    }
    
    @IBAction func switchValueDidChange(_ sender: UISwitch) {
        delegate?.switchDidTap(checkerSwitch)
    }

}
