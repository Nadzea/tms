//
//  StyleOfCheckerViewController.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 15.09.21.
//

import UIKit

class StyleOfCheckerViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    var dataSource: [StyleOfChecker] = [StyleOfChecker(whiteChecker: "style1WhiteChecker",
                                                       blackChecker: "style1BlackChecker",
                                                       stateSwitch: true),
                                        StyleOfChecker(whiteChecker: "style2WhiteChecker",
                                                       blackChecker: "style2BlackChecker",
                                                       stateSwitch: false),
                                        StyleOfChecker(whiteChecker: "style3WhiteChecker",
                                                       blackChecker: "style3BlackChecker",
                                                       stateSwitch: false)]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.layer.cornerRadius = 30
        
        screenSettings(buttonLabel: buttonLabel, blurView: blurView)

        setupCollectionView()
        
        if manager.fileExists(atPath: documentDirectory.appendingPathComponent("styleOfChecker").path) {
            dataSource = SaveData.getStyleChecker()
        }
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "StyleOfCheckerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StyleOfCheckerCollectionViewCell")
    }
    
    @IBAction func backScreenButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension StyleOfCheckerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StyleOfCheckerCollectionViewCell", for: indexPath) as? StyleOfCheckerCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setData(with: dataSource[indexPath.item])
        
        cell.checkerSwitch.tag = indexPath.item
        
        cell.delegate = self
        
        return cell
    }
}

extension StyleOfCheckerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 130)
    }
}

extension StyleOfCheckerViewController: StyleOfCheckerCollectionViewCellDelegate {
    func switchDidTap(_ sender: UISwitch) {
        for i in 0..<dataSource.count {
            dataSource[i].stateSwitch = i == sender.tag
        }
        collectionView.reloadData()
        SaveData.saveStyleOfChecker(styleOfCheckers: dataSource)
    }
}

