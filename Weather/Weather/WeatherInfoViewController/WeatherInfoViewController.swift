//
//  WeatherInfoViewController.swift
//  Weather
//
//  Created by Надежда Клименко on 21.09.21.
//

import UIKit

class WeatherInfoViewController: UIViewController {
    
    @IBOutlet weak var testView: TestView!
    
    lazy var viewModel: ViewModel = {
        return ViewModel.init(view: self) //lazy проинициализирует только тогда когда к нему обратишься, например напишешь во viewDidLoad print(viewModel)
    }()
    
    var city: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        viewModel.getData(city: city, latitude: nil, longitude: nil)
        
    }
    
    func updateView() {
        
        viewModel.didUpdateViewData = { viewData in
            
            self.testView.viewData = viewData
        }
    }
    
    @IBAction func backScreen(_ senser: Any) {
        viewModel.didUpdateViewData?(.initial)
        self.navigationController?.popViewController(animated: true)
    }
}
