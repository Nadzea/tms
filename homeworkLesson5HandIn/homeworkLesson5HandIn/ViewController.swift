//
//  ViewController.swift
//  homeworkLesson5HandIn
//
//  Created by Надежда Клименко on 28.06.21.
//

import UIKit

class ViewController: UIViewController {
    
    //task5
    
    func massTask5(enterMass task5: [Int]) -> [Int] {
        return task5.reversed()
    }
    func yourRange(_num: Int...) -> [Int] {
        var massRange: [Int] = []
        for number in _num {
            massRange.append(number)
        }
        return massTask5(enterMass: massRange)
    }
    
    //task6
    
    func changeString(enterString stringTask6: String) -> String {
        var massStringTask6: [String] = []
        stringTask6.forEach { value in
            massStringTask6.append(String(value))
        }
        for (index, value) in massStringTask6.enumerated() {
            switch value {
            case "e", "y", "u", "i", "o", "a":
                var newValue = value
                newValue = newValue.uppercased()
                massStringTask6.remove(at: index)
                massStringTask6.insert(newValue, at: index)
            case "q", "w", "r", "t", "p", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m":
                var newValue = value
                newValue = newValue.lowercased()
                massStringTask6.remove(at: index)
                massStringTask6.insert(newValue, at: index)
            case ".", ",", "!", "?", ":", "'", "-", ";":
                massStringTask6.remove(at: index)
                massStringTask6.insert("", at: index)
            case "0":
                massStringTask6.remove(at: index)
                massStringTask6.insert("nul", at: index)
            case "1":
                massStringTask6.remove(at: index)
                massStringTask6.insert("one", at: index)
            case "2":
                massStringTask6.remove(at: index)
                massStringTask6.insert("two", at: index)
            case "3":
                massStringTask6.remove(at: index)
                massStringTask6.insert("tree", at: index)
            case "4":
                massStringTask6.remove(at: index)
                massStringTask6.insert("four", at: index)
            case "5":
                massStringTask6.remove(at: index)
                massStringTask6.insert("five", at: index)
            case "6":
                massStringTask6.remove(at: index)
                massStringTask6.insert("six", at: index)
            case "7":
                massStringTask6.remove(at: index)
                massStringTask6.insert("seven", at: index)
            case "8":
                massStringTask6.remove(at: index)
                massStringTask6.insert("eight", at: index)
            case "9":
                massStringTask6.remove(at: index)
                massStringTask6.insert("nine", at: index)
                
            default:
                break
            }
         }
        var resultTask6: String = ""
        massStringTask6.forEach { value in
            resultTask6.append(value)
        }
        return resultTask6
    }
    
    
    //task7
    
    func findMax(enterMass task7: [Int]) -> Int {
        var maxInMass = task7[0]
        task7.forEach { valueTask7 in
            if valueTask7 > maxInMass {
                maxInMass = valueTask7
            }
        }
        return maxInMass
    }
    
    //task8
    
    func evenOrOdd(enterMass task8: [Int]) -> [Bool] {
        var massOfBool: [Bool] = []
        task8.forEach { valueTask8 in
           if ((valueTask8 % 2) == 0) {
            massOfBool.append(true)
           } else {
            massOfBool.append(false)
           }
        }
        return massOfBool
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //task1
        
        let englishAlphabet: String = "abcdefghijklmnopqrstuvwxyz"
        let const: String = "c"
        for (index, value) in englishAlphabet.enumerated() {
            if String(value) == const {
                print("Symbol '\(const)' is at position \((index) + 1)")
            }
            
        }
        
        //task2
        
        let days: [Int] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        print("вывод количества дней в месяцах")
        days.forEach { valueDays in
            print(valueDays)
        }
        let month: [String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        print("вывод месяц + количество дней")
        for (index, value) in month.enumerated() {
            print("\(value) - \(days[index])")
        }
        //создание массива тюплов
        print("вывод месяц + количество дней через массив тюплов")
        var monthAndDays: [(month: String, day: Int)] = []
        var i = 0
        while i != month.count {
            monthAndDays.append((month[i], days[i]))
            i += 1
        }
        monthAndDays.forEach { valueMonthAndDay in
            print("\(valueMonthAndDay.month) - \(valueMonthAndDay.day)")
        }
        print("обратный вывод")
        for (index, value) in month.enumerated().reversed() {
            print("\(value) - \(days[index])")
        }
        //задаем произвольный день
        let randomDay: Int = 15
        //задаем произвольный месяц
        let randomMonth: String = "September"
        var s: Int = 0 //счетчик количества дней с начала года до необходимой даты
        monthAndDays.forEach { valueMonthAndDay in
            if valueMonthAndDay.month != randomMonth {
                s += valueMonthAndDay.day
            } else {
                s += randomDay - 1
                print("From the beginning of the year until \(randomMonth) \(randomDay) \(s) days")
            }
        }
        
        //task 3
        let alphabet: String = "abcdefghijklmnopqrstuvwxyz"
        var massString: [String] = []
        alphabet.forEach { value in
            massString.insert(String(value), at: 0)
        }
        print(massString)
        
        //task4
        
        let longString: String = "94НН03 С006Щ3НN3 П0К4ЗЫ8437, К4КN3 У9N8N73ЛЬНЫ3 83ЩN М0Ж37 93Л47Ь Н4Ш Р4ЗУМ! 8П3Ч47ЛЯЮЩN3 83ЩN! СН4Ч4Л4 Э70 6ЫЛ0 7РУ9Н0, Н0 С3ЙЧ4С Н4 Э70Й С7Р0К3 84Ш Р4ЗУМ ЧN7437 Э70 4870М47NЧ3СКN, Н3 З49УМЫ84ЯСЬ 06 Э70М. Г0Р9NСЬ. ЛNШЬ 0ПР393Л3ННЫ3 ЛЮ9N М0ГУ7 ПР0ЧN747Ь Э70."
        var numberString: Int = 0 //счетчик букв
        var numberInt: Int = 0 //счетчик цифр
        var numberSymbol: Int = 0 //счетчик символов
        for value in longString.unicodeScalars {
            switch value {
            case "a"..."z":
                numberString += 1
            case "A"..."Z":
                numberString += 1
            case "а"..."я":
                numberString += 1
            case "А"..."Я":
                numberString += 1
            case "0"..."9":
                numberInt += 1
            default:
                numberSymbol += 1
            }
        }
            print("Letters - \(numberString)")
        print("Digits - \(numberInt)")
        print("Symbols - \(numberSymbol)")
        
        //task5
        
        print(massTask5(enterMass: [1, 2, 3, 4, 5, 6]))
        print(yourRange(_num: 5, 6, 7, 8, 9, 10))
        
        //task6
        
        print(changeString(enterString: "Nad:zey! Good MorNing, DeaR. You Must Do 5 Tasks"))
        
        //task7
        
        print("Max digit in mass \(findMax(enterMass: [1,2,3,4,6,2,10,9]))")
        
        //task8
        
        print(evenOrOdd(enterMass: [4, 7, 8, 44]))
        
        
        
        
        
        // Do any additional setup after loading the view.
    }


}

