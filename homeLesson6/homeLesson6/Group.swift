//
//  Group.swift
//  homeLesson6
//
//  Created by Надежда Клименко on 30.06.21.
//

import Foundation

//task2

class Group {
    let nameOfGroup: String
    var students: [Student]
    
    init(nameOfGroup: String, students: [Student]) {
    self.nameOfGroup = nameOfGroup
    self.students = students
    }
    
    //task3
    
    func gracefullyPrint () {
        guard !students.isEmpty else {
            print("Group is empty")
            return
        }
        print(self.nameOfGroup)
        var i: Int = 1
        students.forEach { anyStudent in
            print("Student \(i)")
            print("First name: \(anyStudent.firstName)")
            print("Last name: \(anyStudent.lastName)")
            print("Year of birth: \(anyStudent.yearOfBirth)")
            print("Average mark: \(anyStudent.averageMark)")
            i += 1
        }
    }
    
    //task4
    
    func deleteStudent(enterMinMark minNeedMark: Float) ->[Student]? {
        guard !students.isEmpty else {
            print("Group is empty")
            return nil
        }
        for index in stride(from: self.students.count - 1, through: 0, by: -1) {
            if students[index].averageMark < minNeedMark {
                students.remove(at: index)
            }
        }
        return students
    }
    
//    func deleteStudent1(enterMinMark minNeedMark: Float) {
//        let goodStudents = students.sorted(by: {$0.averageMark > $1.averageMark})
////        self.students.forEach { anyStudent in
////            students.removeAll(where: {_ in anyStudent.averageMark < minNeedMark} )
////        }
//        print(goodStudents)
//    }
    
    
    
}
