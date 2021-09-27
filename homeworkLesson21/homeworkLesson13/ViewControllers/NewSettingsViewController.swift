//
//  NewSettingsViewController.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 14.09.21.
//

import UIKit

class NewSettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var backSettingsScreen: CustomButton!
    
    var dataSource: [Settings] = [Settings(type: "type1_of_settings_screen".localized), Settings(type: "type2_of_settings_screen".localized), Settings(type: "type3_of_settings_screen".localized), Settings(type: "type4_of_settings_screen".localized)]
    
    var dataSourse1: [Settings] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        screenSettings()
        
        backSettingsScreen.delegate = self
    }
    
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(true)
        
        animate()
        
        dataSourse1 = [Settings(type: "type1_of_settings_screen".localized), Settings(type: "type2_of_settings_screen".localized), Settings(type: "type3_of_settings_screen".localized), Settings(type: "type4_of_settings_screen".localized)]
        
        screenSettings()
        
        tableView.reloadData()
    }
    
    func screenSettings() {
        settingsLabel.text = "settings_label_text".localized
        let currentLanguage = SaveData.getSaveCurrentLanguage()
        if currentLanguage == "ru" {
            settingsLabel.addAttributedTextWithLavanderiaScript(with: .black, foregroundColor: .white, strokeWidth: -2, size: 48)
        } else {
            settingsLabel.addAttributedText(with: .black, foregroundColor: .white, strokeWidth: -2, size: 48)
        }
        
    }
    
    func animate() {
        settingsLabel.transform = .identity
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.repeat, .autoreverse]) {
            self.settingsLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }
    
    private func chooseScreenBackground() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true, completion: nil)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
        tableView.tableFooterView = UIView()
    }
}

extension NewSettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell") as? SettingsTableViewCell  else {
            return UITableViewCell()
        }
        if !dataSourse1.isEmpty {
            cell.setup(with: dataSourse1[indexPath.row])
        } else {
            cell.setup(with: dataSource[indexPath.row])
        }
        
        let currentLanguage = SaveData.getSaveCurrentLanguage()
        if currentLanguage == "ru" {
            cell.addLavanderiaFont()
        } else {
            cell.addFont()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
}

extension NewSettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.row == 0 {
            present(getViewController(with: "StyleOfCheckerViewController"), animated: true, completion: nil)
        }
        
        if indexPath.row == 1 {
            chooseScreenBackground()
        }
        
        if indexPath.row == 2 {
            present(getViewController(with: "SoundsViewController"), animated: true, completion: nil)
        }
        
        if indexPath.row == 3 {
            present(getViewController(with: "LanguageViewController"), animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
}

extension NewSettingsViewController: CustomButtonDelegate {
    func buttonDidTap(_ sender: CustomButton) {
        
        dismiss(animated: true, completion: nil)
    }
}

extension NewSettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        
        SaveData.saveImageForScreen(image: image)
        
        picker.dismiss(animated: true)
    }
}

