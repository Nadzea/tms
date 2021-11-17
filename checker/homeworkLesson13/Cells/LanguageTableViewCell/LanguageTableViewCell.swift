//
//  LanguageTableViewCell.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 15.09.21.
//

import UIKit
protocol LanguageTableViewCellDelegate: AnyObject {
    func switchDidTap(_ sender: UISwitch)
}

class LanguageTableViewCell: UITableViewCell {
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var languageSwitch: UISwitch!
    
    weak var delegate: LanguageTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        languageSwitch.onTintColor = .black
        languageSwitch.thumbTintColor = .white
    }
    
    func setData(with language: SettingsOfLanguage) {
        self.languageLabel.text = language.language
        self.languageSwitch.setOn(language.stateSwitch, animated: true)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        languageLabel.text = ""
    }
    
    func addFont() {
        languageLabel.addAttributedText(with: .black, foregroundColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), strokeWidth: -2, size: 40)
    }
    
    func addLavanderiaFont() {
        languageLabel.addAttributedTextWithLavanderiaScript(with: .black, foregroundColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), strokeWidth: -2, size: 40)
    }
    
    @IBAction func switchValueDidChange(_ sender: UISwitch) {
        delegate?.switchDidTap(languageSwitch)
    }
    
}
