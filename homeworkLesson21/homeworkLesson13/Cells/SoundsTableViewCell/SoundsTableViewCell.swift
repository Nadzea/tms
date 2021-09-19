//
//  SoundsTableViewCell.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 15.09.21.
//

import UIKit
protocol SoundsTableViewCellDelegate: AnyObject {
    func switchDidTap(_ sender: UISwitch)
}

class SoundsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var typeOfSounds: UILabel!
    @IBOutlet weak var soundsSwitch: UISwitch!
    
    weak var delegate: SoundsTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        soundsSwitch.onTintColor = .black
        soundsSwitch.thumbTintColor = .white
        
    }
    
    func setData(with typeOfSounds: SettingsOfSounds) {
        self.typeOfSounds.text = typeOfSounds.typeSounds
        self.soundsSwitch.setOn(typeOfSounds.stateSwitch, animated: true)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        typeOfSounds.text = ""
    }
    
    func addFont() {
        typeOfSounds.addAttributedText(with: .black, foregroundColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), strokeWidth: -2, size: 40)
    }
    
    func addLavanderiaFont() {
        typeOfSounds.addAttributedTextWithLavanderiaScript(with: .black, foregroundColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), strokeWidth: -2, size: 40)
    }
    
    @IBAction func switchValueDidChange(_ sender: UISwitch) {
        delegate?.switchDidTap(soundsSwitch)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
