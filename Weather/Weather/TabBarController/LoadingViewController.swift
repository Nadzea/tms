//
//  LoadingViewController.swift
//  Weather
//
//  Created by Надежда Клименко on 21.10.21.
//

import UIKit
import NVActivityIndicatorView

class LoadingViewController: UIViewController {

    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        activityIndicator.startAnimating()
    }
}
