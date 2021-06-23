//
//  ViewController.swift
//  homeLesson4HandIn
//
//  Created by Надежда Клименко on 23.06.21.
//

import UIKit

class ViewController: UIViewController {
    //task1
    func increaseSalary(enterAge age: Int, salary: inout Float) {
        switch age {
        case 18...30:
            salary = 1.5 * salary
        case 31...40:
            salary = 2 * salary
        default:
            salary = 3 * salary
        }
    }
    
    //task2
    func average(enterNumber1 number1: Int, number2: Int, number3: Int) {
        let result = ((Float(number1) + Float(number2) + Float(number3)) / 3)
        print("Average \(number1), \(number2), \(number3) = \(result)")
    }
    //task3
    
    func credit(enterSum sum: Int, period: Int, percent: Float) {
        let sumEveryMonth = (Float(sum) * percent / 100 * pow((1 + percent/100), Float(period))) / (12 * (pow((1 + percent/100), Float(period)) - 1))
        let sumForPeriod = (sumEveryMonth * 12) * Float(period)
        print("Sum of credit: \(sum) rub")
        print("Period of credit: \(period) years")
        print("Percent of credit: \(percent)%")
        print("Sum every month \(Int(sumEveryMonth)) rub")
        print("Sum for period \(Int(sumForPeriod)) rub")

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //task1
        var person1: (name: String, age: Int, salary: Float) = ("Nadya", 35, 1900.46)
        var person2: (name: String, age: Int, salary: Float) = ("Nick", 42, 2320.55)
        var person3: (name: String, age: Int, salary: Float) = ("Nastya", 25, 1506.12)
        
        increaseSalary(enterAge: person1.age, salary: &person1.salary)
        increaseSalary(enterAge: person2.age, salary: &person2.salary)
        increaseSalary(enterAge: person3.age, salary: &person3.salary)
        print("Name: \(person1.name), Age: \(person1.age), Salary: \(person1.salary)") //можно ли вывести тюпл без скобок?
        print("Name: \(person2.name), Age: \(person2.age), Salary: \(person2.salary)")
        print("Name: \(person3.name), Age: \(person3.age), Salary: \(person3.salary)")
        
        //task2
        
        average(enterNumber1: 4, number2: 8, number3: 5)
        
        //task3
        credit(enterSum: 1000000, period: 10, percent: 12.0)
        
        
        // Do any additional setup after loading the view.
    }


}

