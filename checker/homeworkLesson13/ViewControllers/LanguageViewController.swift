//
//  LanguageViewController.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 15.09.21.
//

import UIKit
enum Language: Int {
    case english = 0
    case russian = 1
}

class LanguageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    var dataSource: [SettingsOfLanguage] = [SettingsOfLanguage(language: "English", stateSwitch: true), SettingsOfLanguage(language: "Pyccкий", stateSwitch: false)]
    
    let lCodes: [String] = ["en", "ru"]
    
    var currentLanguage: Language = .english {
        didSet {
            switch self.currentLanguage {
            case .english: SettingsManager.shared.currentLanguageCode = "en"
            case .russian: SettingsManager.shared.currentLanguageCode = "ru"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenSettings(buttonLabel: buttonLabel, blurView: blurView)

        setupTableView()
        
        if manager.fileExists(atPath: documentDirectory.appendingPathComponent("settingsOfLanguage").path) {
            dataSource = SaveData.getSettingsOfLanguage()
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "LanguageTableViewCell", bundle: nil), forCellReuseIdentifier: "LanguageTableViewCell")
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func backScreenButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}

extension LanguageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageTableViewCell") as? LanguageTableViewCell  else {
            return UITableViewCell()
        }
        cell.setData(with: dataSource[indexPath.row])
        
        cell.languageSwitch.tag = indexPath.item
        
        if indexPath.row == 1 {
            cell.addLavanderiaFont()
        } else {
            cell.addFont()
        }
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
}

extension LanguageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension LanguageViewController: LanguageTableViewCellDelegate {
    func switchDidTap(_ sender: UISwitch) {
        for i in 0..<dataSource.count {
            dataSource[i].stateSwitch = i == sender.tag
        }
        tableView.reloadData()
        
        guard let selectedlanguage = Language(rawValue: sender.tag) else { return }
        currentLanguage = selectedlanguage
        
        screenSettings(buttonLabel: buttonLabel, blurView: blurView)
        SaveData.saveSettingsOfLanguage(languages: dataSource)
    }
}

