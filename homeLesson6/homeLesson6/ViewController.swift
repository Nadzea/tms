//
//  ViewController.swift
//  homeLesson6
//
//  Created by Надежда Клименко on 30.06.21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //создаем экземпляры класса Student
        
        let student1: Student = Student(firstName: "Klimenko",
                                        lastName: "Nadzeya" ,
                                        yearOfBirth: 1986,
                                        averageMark: 5.8)
        let student2: Student = Student(firstName: "Golovatenko",
                                        lastName: "Svetlana",
                                        yearOfBirth: 1985,
                                        averageMark: 5.1)
        let student3: Student = Student(firstName: "Bobrova",
                                        lastName: "Nastya",
                                        yearOfBirth: 1986,
                                        averageMark: 8.6)
        
        //создаем экземпляр класса Group
        
        let group1: Group = Group(nameOfGroup: "IOS",
                                  students: [student1, student2, student3])
        
        //вызов метода gracefullyPrint task3
        
        group1.gracefullyPrint()
        
        
        //task4
        
        group1.deleteStudent(enterMinMark: 6.4)
        print("Group after remove students")
        group1.gracefullyPrint()
        
        
        
        
        
        // Do any additional setup after loading the view.
    }


}

