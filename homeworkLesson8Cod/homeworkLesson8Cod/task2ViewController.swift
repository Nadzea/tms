//
//  task2ViewController.swift
//  homeworkLesson8Cod
//
//  Created by Надежда Клименко on 7.07.21.
//

import UIKit

class task2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 200 / 255, green: 150 / 255, blue: 100 / 255, alpha: 1.0)
        
        for row in 0..<8 {
            for column in 0..<8 {
            let newView = UIView(frame: CGRect(x: 15 + row * 45,
                                               y: 100 + column * 45,
                                               width: 45,
                                               height: 45))
                if (row + column) % 2 == 0 {
                    newView.backgroundColor = .black
                } else {
                    newView.backgroundColor = .white
                }
            view.addSubview(newView)

            }
        }
        
        
        
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
