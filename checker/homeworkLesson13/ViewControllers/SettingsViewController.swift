//
//  SettingsViewController.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 24.07.21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backSettingsScreen: CustomButton!
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var backgroundLabel: UILabel!
    @IBOutlet weak var chooseBackground: CustomButtonMainView!
    @IBOutlet weak var soundsLabel: UILabel!
    @IBOutlet weak var soundsSwitch: UISwitch!
    
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
        
        screenSettings()
    
        setupCollectionView()
        
        backSettingsScreen.delegate = self
        chooseBackground.delegate = self
        
        if manager.fileExists(atPath: documentDirectory.appendingPathComponent("styleOfChecker").path) {
            dataSource = SaveData.getStyleChecker()
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.repeat, .autoreverse]) {
            self.settingsLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }
    
    func screenSettings() {
        
        settingsLabel.addAttributedText(with: .black, foregroundColor: .white, strokeWidth: -2, size: 48)
        styleLabel.addAttributedText(with: .black, foregroundColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), strokeWidth: -2, size: 40)
        backgroundLabel.addAttributedText(with: .black, foregroundColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), strokeWidth: -2, size: 40)
        collectionView.layer.cornerRadius = 30
        backSettingsScreen.addShadow(with: .black, opacity: 0.9, shadowOffset: CGSize(width: 10, height: 10))
        chooseBackground.addShadow(with: .black, opacity: 0.9, shadowOffset: CGSize(width: 10, height: 10))
        soundsLabel.addAttributedText(with: .black, foregroundColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), strokeWidth: -2, size: 40)
        soundsSwitch.onTintColor = .black
        soundsSwitch.thumbTintColor = .white
        soundsSwitch.isOn = SaveData.getPlayMusicIsNeeded()
    }
    
    private func chooseScreenBackground() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "StyleOfCheckerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StyleOfCheckerCollectionViewCell")
    }
}

extension SettingsViewController: UICollectionViewDataSource {
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

extension SettingsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 130)
    }
}

extension SettingsViewController: StyleOfCheckerCollectionViewCellDelegate {
    func switchDidTap(_ sender: UISwitch) {
        for i in 0..<dataSource.count {
            dataSource[i].stateSwitch = i == sender.tag 
        }
        collectionView.reloadData()
    }
}

extension SettingsViewController: CustomButtonDelegate {
    func buttonDidTap(_ sender: CustomButton) {
        
        SaveData.saveStyleOfChecker(styleOfCheckers: dataSource)
        SaveData.playMusicIsNeeded(musicSwitch: soundsSwitch.isOn)
    
        dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController: CustomButtonMainViewDelegate {
    func buttonDidTap(_ sender: CustomButtonMainView) {
        chooseScreenBackground()
    }
}

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        
        SaveData.saveImageForScreen(image: image)
        
        picker.dismiss(animated: true)
    }
}
