//
//  NewsModels.swift
//  Weather
//
//  Created by Надежда Клименко on 22.10.21.
//

import Foundation

struct Articles: Codable {
    var title: String? = ""
    var description: String? = ""
    var url: String = ""
    
}

struct News: Codable {
    var articles: [Articles] = []
}
