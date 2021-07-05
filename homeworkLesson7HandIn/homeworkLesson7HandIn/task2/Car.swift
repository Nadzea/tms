//
//  Car.swift
//  homeworkLesson7HandIn
//
//  Created by Надежда Клименко on 5.07.21.
//

import Foundation

class Car: TransportMean {
    override init(speed: Int, capacity: Int, costOneKil: Float) {
        super.init(speed: speed, capacity: capacity, costOneKil: costOneKil)
    }
    override func transportation(enterNumberOfPassenger passangers: Int, distance: Int) {
        print("_____________")
        print("Car")
        super.transportation(enterNumberOfPassenger: passangers, distance: distance)
    }
}
