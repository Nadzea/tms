//
//  RealmManager.swift
//  Weather
//
//  Created by Надежда Клименко on 7.10.21.
//

import UIKit
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    let localRealm = try! Realm()
    
    func createRequest(viewModel: ViewModel, date: Date) {

        let request = Request(dateOfRequest: date, cityName: viewModel.cityName, temperature: viewModel.temperature, tempFeelLikes: viewModel.feelLikesLabel, descriptionLabel: viewModel.descriptionLabel, wind: viewModel.windLabel)
        
        do {
            try localRealm.write {
                localRealm.add(request)
                print("realm")
            }
        } catch(let e) {
            print(e)
        }
    }
    
    func getAllRequest() -> [Request] {
        let requests = localRealm.objects(Request.self)
        
        return requests.reversed()
    }
}
