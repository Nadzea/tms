//
//  SoundsViewController.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 15.09.21.
//

import UIKit

class SoundsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    var dataSource: [SettingsOfSounds] = [SettingsOfSounds(typeSounds: "type_of_settings_sounds".localized, stateSwitch: true)]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenSettings(buttonLabel: buttonLabel, blurView: blurView)
        
        if manager.fileExists(atPath: documentDirectory.appendingPathComponent("playMusic").path) {
            dataSource[0].stateSwitch = SaveData.getPlayMusicIsNeeded()
        }

        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "SoundsTableViewCell", bundle: nil), forCellReuseIdentifier: "SoundsTableViewCell")
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func backScreenButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension SoundsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SoundsTableViewCell") as? SoundsTableViewCell  else {
            return UITableViewCell()
        }
        cell.setData(with: dataSource[indexPath.row])
        
        let currentLanguage = SaveData.getSaveCurrentLanguage()
        if currentLanguage == "ru" {
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

extension SoundsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SoundsViewController: SoundsTableViewCellDelegate {
    func switchDidTap(_ sender: UISwitch) {
        
        SaveData.playMusicIsNeeded(musicSwitch: sender.isOn)
    }
}
