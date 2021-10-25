//
//  NewsTableViewCell.swift
//  Weather
//
//  Created by Надежда Клименко on 23.10.21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(with news: News_) {
        titleLabel.text = news.title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
    }
}
