//
//  ResultsTableViewCell.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 24.09.21.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateOfPlay: UILabel!
    @IBOutlet weak var nameOfPlayer1: UILabel!
    @IBOutlet weak var nameOfPlayer2: UILabel!
    @IBOutlet weak var colorOfCheckerPlayer1: UILabel!
    @IBOutlet weak var colorOfCheckerPlayer2: UILabel!
    @IBOutlet weak var winnerPlayer1: UILabel!
    @IBOutlet weak var winnerPlayer2: UILabel!
    @IBOutlet weak var nameOfPlayer1Label: UILabel!
    @IBOutlet weak var nameOfPlayer2Label: UILabel!
    @IBOutlet weak var colorOfCheckerPlayer1Label: UILabel!
    @IBOutlet weak var colorOfCheckerPlayer2Label: UILabel!
    
    let dateFormater = DateFormatter()
    let date = Date()

    override func awakeFromNib() {
        super.awakeFromNib()
        nameOfPlayer1Label.text = "nameOfPlayer1Label_text".localized
        nameOfPlayer2Label.text = "nameOfPlayer2Label_text".localized
        colorOfCheckerPlayer1Label.text = "colorOfCheckerPlayerLabel_text".localized
        colorOfCheckerPlayer2Label.text = "colorOfCheckerPlayerLabel_text".localized
    }
    
    func setData(with play: Play) {
        dateFormater.dateFormat = "dd.MM.yy"
        let date = play.dateOfPlay
        if let date = date {
            self.dateOfPlay.text = dateFormater.string(from: date)
        }
        let players = CoreDataManager.shared.getPlayer(by: play)
        
        self.nameOfPlayer1.text = players[0].name
        self.colorOfCheckerPlayer1.text = players[0].colorOfChecker
        self.nameOfPlayer2.text = players[1].name
        self.colorOfCheckerPlayer2.text = players[1].colorOfChecker
        
        self.winnerPlayer1.text = players[0].winner == true ? "winner_results".localized : "loser_results".localized
        self.winnerPlayer2.text = players[1].winner == true ? "winner_results".localized : "loser_results".localized
    
        self.winnerPlayer1.textColor = self.winnerPlayer1.text == "winner_results".localized ? .purple : .black
        self.winnerPlayer2.textColor = self.winnerPlayer2.text == "winner_results".localized ? .purple : .black
        self.colorOfCheckerPlayer1.text = colorOfCheckerPlayer1.text == "black" ? "black_colorOfCheckerLabel_text".localized : "white_colorOfCheckerLabel_text".localized
        self.colorOfCheckerPlayer2.text = colorOfCheckerPlayer2.text == "black" ? "black_colorOfCheckerLabel_text".localized : "white_colorOfCheckerLabel_text".localized
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dateOfPlay.text = ""
        nameOfPlayer1.text = ""
        nameOfPlayer2.text = ""
        colorOfCheckerPlayer1.text = ""
        colorOfCheckerPlayer2.text = ""
        winnerPlayer1.text = ""
        winnerPlayer2.text = ""
        
    }

    
    
}
