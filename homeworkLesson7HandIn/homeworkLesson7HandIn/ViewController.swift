//
//  ViewController.swift
//  homeworkLesson7HandIn
//
//  Created by Надежда Клименко on 4.07.21.
//

import UIKit

class ViewController: UIViewController {
    
    //task1
    
    func appendArtist(_artists: Artist...) -> [Artist] {
        var massArtist: [Artist] = []
        for valueArtist in _artists {
            massArtist.append(valueArtist)
        }
        return massArtist
    }
    
    //task3
    
//    func appendCreatures(_creatures: LivingCreatures...) -> [LivingCreatures] {
//        var massCreatures: [LivingCreatures] = []
//        for valueCreature in _creatures {
//            massCreatures.append(valueCreature)
//        }
//        return massCreatures
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //task1
        
        let dancer: Dancer = Dancer(firstName: "Anastasia",
                                    lastName: "Volochkova")
        
        let singer: Singer = Singer(firstName: "Alla",
                                    lastName: "Pugacheva")
        
        let painter: Painter = Painter(firstName: "Moisei",
                                       lastName: "Kunin")
        
        let actor: Actor = Actor(firstName: "Bruce",
                                 lastName: "Willis")
        
        let massArtist = appendArtist(_artists: dancer, singer, painter, actor)
        massArtist.forEach { value in
            guard !massArtist.isEmpty else {
                return
            }
            print(value.performance())
        }
        
        //task2
        
        let flight: Flight = Flight(speed: 800,
                                    capacity: 100,
                                    costOneKil: 0.5)
        
        let ship: Ship = Ship(speed: 80,
                              capacity: 90,
                              costOneKil: 0.2)
        
        let helicopter: Helicopter = Helicopter(speed: 280,
                                                capacity: 28,
                                                costOneKil: 0.8)
        
        let car: Car = Car(speed: 100,
                           capacity: 4,
                           costOneKil: 0.06)
        
        var massTransportMean: [TransportMean] = []
        massTransportMean.append(flight)
        massTransportMean.append(ship)
        massTransportMean.append(helicopter)
        massTransportMean.append(car)
        massTransportMean.forEach { value in
            guard !massTransportMean.isEmpty else {
                return
            }
            print(value.transportation(enterNumberOfPassenger: 240, distance: 500))
        }
        
        //task3
        
        let human1: Human = Human()
        let human2: Human = Human()
        let crocodale1: Crocodile = Crocodile()
        let crocodale2: Crocodile = Crocodile()
        let monkey1: Monkey = Monkey()
        let monkey2: Monkey = Monkey()
        let dog1: Dog = Dog()
        let dog2: Dog = Dog()
        let giraffe1: Giraffe = Giraffe()
        let giraffe2: Giraffe = Giraffe()
        var hasFourLegs: Int = 0
        var animals: Int = 0
        var livingCreatures: Int = 0
        
        let massCreatures: [LivingCreatures] = [human1, human2, crocodale1, crocodale2, monkey1, monkey2, dog1, dog2, giraffe1, giraffe2]
        
        massCreatures.forEach { creature in
            guard !massCreatures.isEmpty else {
                return
            }
            if creature.numberOfLegs == 4 {
                hasFourLegs += 1
            }
            if creature.animal == true {
                animals += 1
            }
            if creature.living == true {
                livingCreatures += 1
            }
        }
        print("There are \(hasFourLegs) living creatures with 4 legs")
        print("There are \(animals) animals")
        print("There are \(livingCreatures) living creatures")
        
    }


}

