//
//  ResultsViewController.swift
//  homeworkLesson13
//
//  Created by Надежда Клименко on 24.07.21.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backResultsScreen: CustomButton!
    @IBOutlet weak var clearResultsButton: UIButton!
    @IBOutlet weak var resultsLabel: UILabel!
    
    var dataSource: [Play] = []
    var players: [Player] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenSettings()
        
        backResultsScreen.delegate = self
        
        let plays = CoreDataManager.shared.getPlays()
        dataSource = plays
        
        setupTableView()
        
    }
    
    func screenSettings() {
        self.view.addGradient(with: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        clearResultsButton.layer.cornerRadius = 20
        clearResultsButton.setTitle("clearResultsButton_text".localized, for: .normal)
        resultsLabel.text = "resultsLabel_text".localized
        resultsLabel.addAttributedTextWithLavanderiaScript(with: .black, foregroundColor: .lightGray, strokeWidth: -2, size: 35)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ResultsTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultsTableViewCell")
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func deleteCoreData(_ sender: Any) {
        CoreDataManager.shared.deleteAllData()
        dataSource = []
        tableView.reloadData()
    }
    
}
extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsTableViewCell") as? ResultsTableViewCell  else {
            return UITableViewCell()
        }
        
        cell.setData(with: dataSource[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
}

extension ResultsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
    
}

extension ResultsViewController: CustomButtonDelegate {
    func buttonDidTap(_ sender: CustomButton) {
        dismiss(animated: true, completion: nil)
    }
}
