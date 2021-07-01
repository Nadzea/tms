//
//  Student.swift
//  homeLesson6
//
//  Created by Надежда Клименко on 30.06.21.
//

import Foundation

//task1

class Student {             //создаем класс
    let firstName: String   //свойства класса
    let lastName: String
    let yearOfBirth: Int
    let averageMark: Float
// инициализация класса
    init(firstName: String, lastName: String, yearOfBirth: Int, averageMark: Float) {
    self.firstName = firstName       //справа параметры инициализатора
    self.lastName = lastName         //self означает, что записанная после него переменная
    self.yearOfBirth = yearOfBirth   //относится к текущему экземпляру класса
    self.averageMark = averageMark
    }
    
}
