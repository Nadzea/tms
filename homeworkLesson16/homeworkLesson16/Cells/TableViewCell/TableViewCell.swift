//
//  TableViewCell.swift
//  homeworkLesson16
//
//  Created by Надежда Клименко on 4.08.21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameCell: UILabel!
    
    override func awakeFromNib() { //метод вызывается при инициализации ячейки
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) { //вызывается когда делаем ячейку выбранной
        super.setSelected(selected, animated: animated)

    }
    
    func setData(with currentCell: CurrentCell) {
        
        nameCell.text = currentCell.name
        nameCell.textColor = currentCell.color
    
    }
    
    override func prepareForReuse() { //метод для дефолтного состояния ячейки
        super.prepareForReuse()
        
        nameCell.text = ""
    }
    
}
