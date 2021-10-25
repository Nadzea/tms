//
//  FullNewsViewController.swift
//  Weather
//
//  Created by Надежда Клименко on 24.10.21.
//

import UIKit
import WebKit

class FullNewsViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var url: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        
        webView.load(request)

    }
    
    @IBAction func backScreen(_ senser: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
