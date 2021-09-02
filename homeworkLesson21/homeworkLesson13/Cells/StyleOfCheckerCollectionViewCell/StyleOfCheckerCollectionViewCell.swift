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
        checkerSwitch.onTintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        checkerSwitch.thumbTintColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
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
