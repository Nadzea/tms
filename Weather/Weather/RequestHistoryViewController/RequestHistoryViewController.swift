//
//  RequestHistoryViewController.swift
//  Weather
//
//  Created by Надежда Клименко on 8.10.21.
//

import UIKit

class RequestHistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: [Request] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        
        dataSource = RealmManager.shared.getAllRequest()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "RequestHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "RequestHistoryTableViewCell")
        tableView.tableFooterView = UIView()
    }
    

    @IBAction func backScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension RequestHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RequestHistoryTableViewCell") as? RequestHistoryTableViewCell  else {
            return UITableViewCell()
        }
        
        cell.setData(with: dataSource[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
}

extension RequestHistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
