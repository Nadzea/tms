//
//  RequestHistoryViewController.swift
//  Weather
//
//  Created by Надежда Клименко on 8.10.21.
//

import UIKit
import RxSwift
import RxCocoa

class RequestHistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = BehaviorSubject<[Request]>(value: [])
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requests: [Request] = RealmManager.shared.getAllRequest()
        
        tableView.register(UINib(nibName: "RequestHistoryTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "RequestHistoryTableViewCell")
        dataSource.bind(to: tableView.rx.items(cellIdentifier: "RequestHistoryTableViewCell", cellType: RequestHistoryTableViewCell.self)) { index, request, cell in
            cell.setData(with: request)
        }.disposed(by: disposeBag)
        
        tableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
 
        dataSource
            .onNext(requests)
    }

    @IBAction func backScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension RequestHistoryViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
