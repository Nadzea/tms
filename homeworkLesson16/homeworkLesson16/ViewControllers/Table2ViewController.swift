//
//  Table2ViewController.swift
//  homeworkLesson16
//
//  Created by Надежда Клименко on 5.08.21.
//

import UIKit

enum TypeOfStudent: Int {
    case otlichnik = 0
    case horoshist = 1
    case troechnik = 2
    case dvoechnik = 3
}

class Table2ViewController: UIViewController {
    
    @IBOutlet weak var table2View: UITableView!
    
    var studentsArray: [Student] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table2View.dataSource = self //указываем контроллер, который будет реализовывать данные для tableView
        table2View.delegate = self
        table2View.tableFooterView = UIView() //пустой футер, чтобы после заданного количества ячеек не было сепараторов
        
        table2View.register(UINib(nibName: "Table2ViewCell", bundle: nil), forCellReuseIdentifier: "Table2ViewCell") //привязываем ячейку
        
        let firstNameArray: [String] = ["Klimenko", "Bondarenko", "Soldatov", "Skripka", "Medvedev", "Martunov", "Bobryiko", "Chub", "Danilchuck", "Griboedov", "Sidorenko", "Hodas", "Veremeev" ]
        let lastNameArray: [String] = ["Stepan", "Kostya", "Sergey", "Vasya", "Nicolai", "Oleg", "Gleb", "Kirill", "Victor", "Tolik"]
        
        for _ in 1...20 {
            let currentStudent = Student(firstName: firstNameArray.randomElement()!, lastName: lastNameArray.randomElement()!, averageMark: .random(in: 2...5))
            studentsArray.append(currentStudent)
        }
        
        studentsArray = studentsArray.sorted {$0.firstName < $1.firstName}
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension Table2ViewController: UITableViewDataSource { // делегат, реализовываем два обязательных метода, без которых таблица не может существовать
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = TypeOfStudent(rawValue: section) else { return 0 }
        
        switch section {
        
        case .otlichnik: return studentsArray.filter {$0.averageMark > 4.5}.count
            
        case .horoshist: return studentsArray.filter {$0.averageMark > 4 && $0.averageMark < 4.5}.count
            
        case .troechnik: return studentsArray.filter {$0.averageMark > 3 && $0.averageMark < 4}.count
            
        case .dvoechnik: return studentsArray.filter {$0.averageMark < 3}.count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard let section = TypeOfStudent(rawValue: section) else { return ""}
        
        switch section {
        case .otlichnik: return "Otlichniki"
        case .horoshist: return "Horoshistu"
        case .troechnik: return "Troechniki"
        case .dvoechnik: return "Dvoechniki"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Table2ViewCell") as? Table2ViewCell, let section = TypeOfStudent(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        
        case .otlichnik: cell.setData(with: studentsArray.filter {$0.averageMark > 4.5}[indexPath.row])
            
        case .horoshist: cell.setData(with: studentsArray.filter {$0.averageMark > 4 && $0.averageMark < 4.5}[indexPath.row])
            
        case .troechnik: cell.setData(with: studentsArray.filter {$0.averageMark > 3 && $0.averageMark < 4}[indexPath.row])
            
        case .dvoechnik: cell.setData(with: studentsArray.filter {$0.averageMark < 3}[indexPath.row])
        }
        
        cell.nameLabel.textColor = Float(cell.averageMark.text!)! < 3.5 ? .red : .black
        
        return cell
    }
    
}
extension Table2ViewController: UITableViewDelegate { //задаем высоту ячеек
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //ячейка которая выбрана
        tableView.deselectRow(at: indexPath, animated: true) //анимационно подсвечивается серым потом этот фон исчезает
    }
}
