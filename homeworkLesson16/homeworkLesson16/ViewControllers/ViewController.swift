//
//  ViewController.swift
//  homeworkLesson16
//
//  Created by Надежда Клименко on 3.08.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataArray: [CurrentCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.dataSource = self //указываем контроллер, который будет реализовывать данные для tableView
        tableView.delegate = self
        tableView.tableFooterView = UIView() //пустой футер, чтобы после заданного количества ячеек не было сепараторов
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell") //привязываем ячейку которя сделана в xib

        for i in 1...200 {
            let cgRed: CGFloat = .random(in: 0...255)
            let cgGreen: CGFloat = .random(in: 0...255)
            let cgBlue: CGFloat = .random(in: 0...255)
            
            let colorCell = UIColor(red: cgRed / 255, green: cgGreen / 255, blue: cgBlue / 255, alpha: 1.0)

            let newCurrentCell = CurrentCell(name: "cell \(i): RGB (\(Int(cgRed)), \(Int(cgGreen)), \(Int(cgBlue)))", color: colorCell)
            
            dataArray.append(newCurrentCell)
        }
    }
    
    @IBAction func table2Button(_ sender: UIButton) {
        let currentStoryboard = UIStoryboard(name: "Table2ViewController", bundle: nil)
        if let currentViewController = currentStoryboard.instantiateInitialViewController() {
            currentViewController.modalPresentationStyle = .fullScreen
            currentViewController.modalTransitionStyle = .flipHorizontal
            present(currentViewController, animated: true, completion: nil)
        }
    }
}

extension ViewController: UITableViewDataSource { // делегат, реализовываем два обязательных метода, без которых таблица не может существовать
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell else { return UITableViewCell() }
        
        cell.setData(with: dataArray[indexPath.row])
        
        return cell
    }
    
}
extension ViewController: UITableViewDelegate { //задаем высоту ячеек
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //ячейка которая выбрана
        tableView.deselectRow(at: indexPath, animated: true) //анимационно подсвечивается серым потом этот фон исчезает
    }
}

