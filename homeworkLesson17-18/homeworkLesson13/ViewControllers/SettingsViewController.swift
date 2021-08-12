//
//  SettingsViewController.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 24.07.21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backSettingsScreen: UIButton!
    
    var styleOfChecker: [(white:(UIImage), black:(UIImage))] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGradient(with: #colorLiteral(red: 0.3084577813, green: 0.8235294223, blue: 0.6689409236, alpha: 1), #colorLiteral(red: 0.8111680768, green: 0.6732622305, blue: 0.9686274529, alpha: 1))
        
        styleOfChecker = [(white: #imageLiteral(resourceName: "style1whiteChecker"), black: #imageLiteral(resourceName: "style1blackChecker")), (white: #imageLiteral(resourceName: "style2WhiteChecker"), black: #imageLiteral(resourceName: "style2BlackChecker")), (white: #imageLiteral(resourceName: "style3WhiteChecer"), black: #imageLiteral(resourceName: "style3BlackChecker"))]
    
        setupCollectionView()
        

    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "StyleOfCheckerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StyleOfCheckerCollectionViewCell")
        
    }
    
    @IBAction func backSettingsScreen(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension SettingsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return styleOfChecker.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StyleOfCheckerCollectionViewCell", for: indexPath) as? StyleOfCheckerCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setData(with: styleOfChecker[indexPath.item])
        
        func saveStateSwitchToUserDefaults() {
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(cell.checkerSwitch, forKey: "stateCheckerSwitch")
        }
        
        return cell
    }
}

extension SettingsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 120)
    }
}
