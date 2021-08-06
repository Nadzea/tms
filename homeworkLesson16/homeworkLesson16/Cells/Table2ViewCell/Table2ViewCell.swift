//
//  Table2ViewCell.swift
//  homeworkLesson16
//
//  Created by Надежда Клименко on 5.08.21.
//

import UIKit

class Table2ViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var averageMark: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setData(with currentStudent: Student) {
        
        nameLabel.text = "\(currentStudent.firstName) \(currentStudent.lastName)"
        averageMark.text = String(format: "%.2f", currentStudent.averageMark)
    
    }
    
    override func prepareForReuse() { //метод для дефолтного состояния ячейки
        super.prepareForReuse()
        
        nameLabel.text = ""
        averageMark.text = ""
    }
    
}
