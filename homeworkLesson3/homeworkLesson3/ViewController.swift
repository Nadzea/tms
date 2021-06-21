//
//  ViewController.swift
//  homeworkLesson3
//
//  Created by Надежда Клименко on 19.06.21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //task1
        let myAchievement: (pushup: Int, pullup: Int, situp: Int) = (30, 15, 50)
        print("task1")
        print("Nadzea's progress:")
        print("pushups - \(myAchievement.pushup), pullups - \(myAchievement.pullup), situps - \(myAchievement.situp) ")
        
        //task2
        print("task2")
        print("pushups - \(myAchievement.0)")
        print("pullups - \(myAchievement.pullup)")
        print("situps - \(myAchievement.2)")
        
        //task3
        var friendAchievement = myAchievement
        friendAchievement = (33, 12, 54)
        print("task3")
        print("My friend's progress:")
        print("pushups - \(friendAchievement.pushup), pullups - \(friendAchievement.pullup), situps - \(friendAchievement.situp)")
        
        //task4
        var difference = myAchievement
        difference = (myAchievement.pushup - friendAchievement.pushup, myAchievement.pullup - friendAchievement.pullup, myAchievement.situp - friendAchievement.situp)
        print("task4")
        print("Difference between me and my friend - \(difference)")
        
        //task5 string явно задан
        let stringConst1: String = "bh45b"
        let stringConst2: String = "7"
        let stringConst3: String = "2"
        let stringConst4: String = "9"
        let stringConst5: String = "ks5"
        var sum = 0
        let intConst1 = Int(stringConst1) //опциональный Int
        let intConst2 = Int(stringConst2)
        let intConst3 = Int(stringConst3)
        let intConst4 = Int(stringConst4)
        let intConst5 = Int(stringConst5)
        var resalt: String = ""
        if  intConst1 != nil {
            sum += intConst1!
            resalt = resalt + "\(intConst1!) + "
        } else {
            resalt = resalt + "nil + "
        }
        if intConst2 != nil {
            sum += intConst2!
            resalt = resalt + "\(intConst2!) + "
        } else {
            resalt = resalt + "nil + "
        }
        if intConst3 != nil {
            sum += intConst3!
            resalt = resalt + "\(intConst3!) + "
        } else {
            resalt = resalt + "nil + "
        }
        if intConst4 != nil {
            sum += intConst4!
            resalt = resalt + "\(intConst4!) + "
        } else {
            resalt = resalt + "nil + "
        }
        if intConst5 != nil {
            sum += intConst5!
            resalt = resalt + "\(intConst5!) "
        } else {
            resalt = resalt + "nil"
        }
        print("task5")
        print("\(resalt) = \(sum)")
        
        //task 5 оциональный string
        //первый способ forced unwrapping
                
        let constString1: String? = "6"
        let constString2: String? = "o2"
        let constString3: String? = "8"
        let constString4: String? = "vcdg"
        let constString5: String? = "1"
        var sum1: Int = 0
        var result1: String = ""
        if Int(constString1!) != nil { //в скобке развернула опциональный string в просто string, потом привожу его к int и получаю опциональный int
            sum1 += Int(constString1!)! //развернула выражение Int(constString1!) опционального int в просто int
            result1 += "\(Int(constString1!)!) + "
            //let a = Int(constString1!)! //развернула выражение Int(constString1!) опционального int в просто int
        } else {
            result1 += "nil + "
        }
        if Int(constString2!) != nil {
            sum1 += Int(constString2!)!
            result1 += "\(Int(constString2!)!) + "
        } else {
            result1 += "nil + "
        }
        if Int(constString3!) != nil {
            sum1 += Int(constString3!)!
            result1 += "\(Int(constString3!)!) + "
        } else {
            result1 += "nil + "
        }
        if Int(constString4!) != nil {
            sum1 += Int(constString4!)!
            result1 += "\(Int(constString4!)!) + "
        } else {
            result1 += "nil + "
        }
        if Int(constString5!) != nil {
            sum1 += Int(constString5!)!
            result1 += "\(Int(constString5!)!) ="
        } else {
            result1 += "nil ="
        }
        print("task5")
        print("\(result1) \(sum1)")
        
        //второй способ оператор ??
        
        let constInt1 = Int(constString1!)// получаем опциональный int
        //print(type(of: constInt1))
        let constInt2 = Int(constString2!)
        let constInt3 = Int(constString3!)
        let constInt4 = Int(constString4!)
        let constInt5 = Int(constString5!)
        var sum2 = (constInt1 ?? 0) + (constInt2 ?? 0)
        sum2 += (constInt3 ?? 0) + (constInt4 ?? 0)
        sum2 += (constInt5 ?? 0)
        var result2 = ""
        result2 += constInt1 != nil ? "\(constInt1!) + " : "nil + "
        result2 += constInt2 != nil ? "\(constInt2!) + " : "nil + "
        result2 += constInt3 != nil ? "\(constInt3!) + " : "nil + "
        result2 += constInt4 != nil ? "\(constInt4!) + " : "nil + "
        result2 += constInt5 != nil ? "\(constInt5!) =" : "nil ="
        print("\(result2) \(sum2)")
        //print("\(constInt1 ?? nil) + \(constInt2 ?? nil) + \(constInt3 ?? nil) + \(constInt4 ?? nil) + \(constInt5 ?? nil) = \(sum2)") // такая конструкция выводит опциональный int. Есть ли какая хитрость, чтобы в таком выводе на консоль убрать optional?
        //print(type(of: sum2))
        //print(type(of: constInt1 ?? nil))
        
        // третий способ optional binding
        var sum3: Int = 0
        var result3: String = ""
        if let noOptConstInt1 = constInt1 {
            sum3 += noOptConstInt1
            result3 += "\(noOptConstInt1) + "
        } else {
            result3 += "nil + "
        }
        if let noOptConstInt2 = constInt2 {
            sum3 += noOptConstInt2
            result3 += "\(noOptConstInt2) + "
        } else {
            result3 += "nil + "
        }
        if let noOptConstInt3 = constInt3 {
            sum3 += noOptConstInt3
            result3 += "\(noOptConstInt3) + "
        } else {
            result3 += "nil + "
        }
        if let noOptConstInt4 = constInt4 {
            sum3 += noOptConstInt4
            result3 += "\(noOptConstInt4) + "
        } else {
            result3 += "nil + "
        }
        if let noOptConstInt5 = constInt5 {
            sum3 += noOptConstInt5
            result3 += "\(noOptConstInt5)"
        } else {
            result3 += "nil"
        }
        print("\(result3) = \(sum3)")
        
        //task 6
        let askServer: (code: Int, message: String?, errorMessage: String?) = (Int.random(in: 100..<300), nil, "error")
        print("task6")
        if askServer.code >= 200 && askServer.code < 300 {
            if askServer.message != nil {
            print("\(askServer.code) - \(askServer.message!)")
            } else {
                print("\(askServer.code) - message: nil")
            }
        } else {
            if askServer.errorMessage != nil {
                print("\(askServer.code) - \(askServer.errorMessage!)")
            } else {
                print("\(askServer.code) - errorMessage: nil")
            }
        }
        //task6 without code
        let askServer1: (message: String?, errorMessage: String?) = ("message", nil)
        if askServer1.message != nil {
            print(askServer1.message!)
        } else {
            print(askServer1.errorMessage!)
        }
        
        //task7
        
        var student1: (name: String, numberOfMachine: Int?, markOfTest: Int?)
        var student2: (name: String, numberOfMachine: Int?, markOfTest: Int?)
        var student3: (name: String, numberOfMachine: Int?, markOfTest: Int?)
        var student4: (name: String, numberOfMachine: Int?, markOfTest: Int?)
        var student5: (name: String, numberOfMachine: Int?, markOfTest: Int?)
        student1.name = "Kate"
        student2.name = "Mike"
        student3.name = "Nick"
        student4.name = "Olga"
        student5.name = "Jane"
        student1.numberOfMachine = nil
        student2.numberOfMachine = 15 //если не задавать переменную как nil, по умолчанию она не будет nil?
        student3.numberOfMachine = nil
        student4.numberOfMachine = 5
        student5.numberOfMachine = 7
        student1.markOfTest = 8
        student2.markOfTest = 9
        student3.markOfTest = nil
        student4.markOfTest = nil
        student5.markOfTest = 6
        print("task7")
        var resultStudent1 = "\(student1.name)"
        if student1.numberOfMachine != nil {
            resultStudent1 += " have(has) a machine № \(student1.numberOfMachine!),"
        } else {
            resultStudent1 += " have(has) not a machine,"
        }
        if student1.markOfTest != nil {
            resultStudent1 += " was at the test, his(her) mark \(student1.markOfTest!)"
        } else {
            resultStudent1 += " was absent at the test"
        }
        print(resultStudent1)
        var resultStudent2 = "\(student2.name)"
        if student2.numberOfMachine != nil {
            resultStudent2 += " have(has) a machine № \(student2.numberOfMachine!),"
        } else {
            resultStudent2 += " have(has) not a machine,"
        }
        if student2.markOfTest != nil {
            resultStudent2 += " was at the test, his(her) mark \(student2.markOfTest!)"
        } else {
            resultStudent2 += " was absent at the test"
        }
        print(resultStudent2)
        var resultStudent3 = "\(student3.name)"
        if student3.numberOfMachine != nil {
            resultStudent3 += " have(has) a machine № \(student3.numberOfMachine!),"
        } else {
            resultStudent3 += " have(has) not a machine,"
        }
        if student3.markOfTest != nil {
            resultStudent3 += " was at the test, his(her) mark \(student3.markOfTest!)"
        } else {
            resultStudent3 += " was absent at the test"
        }
        print(resultStudent3)
        var resultStudent4 = "\(student1.name)"
        if student4.numberOfMachine != nil {
            resultStudent4 += " have(has) a machine № \(student4.numberOfMachine!),"
        } else {
            resultStudent4 += " have(has) not a machine,"
        }
        if student4.markOfTest != nil {
            resultStudent4 += " was at the test, his(her) mark \(student4.markOfTest!)"
        } else {
            resultStudent4 += " was absent at the test"
        }
        print(resultStudent4)
        var resultStudent5 = "\(student5.name)"
        if student5.numberOfMachine != nil {
            resultStudent5 += " have(has) a machine № \(student5.numberOfMachine!),"
        } else {
            resultStudent5 += " have(has) not a machine,"
        }
        if student5.markOfTest != nil {
            resultStudent5 += " was at the test, his(her) mark \(student5.markOfTest!)"
        } else {
            resultStudent5 += " was absent at the test"
        }
        print(resultStudent5)
        
        //task8
        
        let tupleOptInt: (one: Int?, two: Int?, three: Int?, four: Int?, five: Int?) = (5, nil, 3, 8, nil)
        var sumOptInt1: Int = 0
        print("task8")
        
        //optional binding
        if let noOpt = tupleOptInt.one {
            sumOptInt1 += noOpt
        }
        if let noOpt = tupleOptInt.two {
            sumOptInt1 += noOpt
        }
        if let noOpt = tupleOptInt.three {
            sumOptInt1 += noOpt
        }
        if let noOpt = tupleOptInt.four {
            sumOptInt1 += noOpt
        }
        if let noOpt = tupleOptInt.five {
            sumOptInt1 += noOpt
        }
        print(sumOptInt1)
        
        //forced unwrapping
        var sumOptInt2: Int = 0
        if tupleOptInt.one != nil {
            sumOptInt2 += tupleOptInt.one!
        }
        if tupleOptInt.two != nil {
            sumOptInt2 += tupleOptInt.two!
        }
        if tupleOptInt.three != nil {
            sumOptInt2 += tupleOptInt.three!
        }
        if tupleOptInt.four != nil {
            sumOptInt2 += tupleOptInt.four!
        }
        if tupleOptInt.five != nil {
            sumOptInt2 += tupleOptInt.five!
        }
        print(sumOptInt2)
        
        //оператор ??
        var sumOptInt3: Int = 0
        sumOptInt3 = (tupleOptInt.one ?? 0) + (tupleOptInt.two ?? 0)
        sumOptInt3 += (tupleOptInt.three ?? 0) + (tupleOptInt.four ?? 0)
        sumOptInt3 += (tupleOptInt.five ?? 0)
        print(sumOptInt3)
        
        
        
      
      
        
      
        
        
    }


}

