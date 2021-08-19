//
//  SettingsViewController.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 24.07.21.
//

import UIKit

enum StateSwitch {
    case isOff
    case isOn
}

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backSettingsScreen: CustomButton!
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    @IBOutlet weak var backgroundLabel: UILabel!
    @IBOutlet weak var chooseBackground: CustomButtonMainView!
    
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
        
        getStyleChecker()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.repeat, .autoreverse]) {
            self.settingsLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }
    
    func screenSettings() {
        self.view.addGradient(with: #colorLiteral(red: 0.4588212766, green: 0.9733110408, blue: 0.9392217259, alpha: 1), #colorLiteral(red: 0.4803237184, green: 0.7373365856, blue: 0.8808781744, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        
        settingsLabel.addAttributedText(with: #colorLiteral(red: 0.2848508313, green: 0.5221149405, blue: 0.4490481728, alpha: 1), foregroundColor: #colorLiteral(red: 0.4627212955, green: 1, blue: 0.8430715997, alpha: 1), strokeWidth: -2, size: 48)
        styleLabel.addAttributedText(with: .black, foregroundColor: .clear, strokeWidth: -2, size: 34)
        backgroundLabel.addAttributedText(with: .black, foregroundColor: .clear, strokeWidth: -2, size: 34)
    }
    
    func saveStyleOfChecker() {
        let data = try? NSKeyedArchiver.archivedData(withRootObject: dataSource, requiringSecureCoding: true)
        let fileURL = documentDirectory.appendingPathComponent("styleOfChecker")
        try? data?.write(to: fileURL)
    }
    
    func getStyleChecker() {
        let fileURL = documentDirectory.appendingPathComponent("styleOfChecker")
        
        guard let data = FileManager.default.contents(atPath: fileURL.absoluteString.replacingOccurrences(of: "file://", with: "")) else { return }
        
        guard let stylesOfChecker = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [StyleOfChecker] else { return }
        self.dataSource = stylesOfChecker
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
        return CGSize(width: 210, height: 160)
    }
}

extension SettingsViewController: StyleOfCheckerCollectionViewCellDelegate {
    func switchDidTap(_ sender: UISwitch) {
        for i in 0..<dataSource.count {
            dataSource[i].stateSwitch = i == sender.tag ? true : false
            collectionView.reloadData()
        }
    }
}

extension SettingsViewController: CustomButtonDelegate {
    func buttonDidTap(_ sender: CustomButton) {
        saveStyleOfChecker()
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
        
        let data = image.pngData()
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            try? data?.write(to: URL(string: "\(documentsPath)/myImage")!, options: .atomic)
//        let fileURL = documentDirectory.appendingPathComponent("imageForPlayScreen")
//        try? data?.write(to: fileURL)
        picker.dismiss(animated: true)
    }
}
