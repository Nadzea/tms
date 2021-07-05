//
//  Flight.swift
//  homeworkLesson7HandIn
//
//  Created by Надежда Клименко on 5.07.21.
//

import Foundation

class Flight: TransportMean {
    override init(speed: Int, capacity: Int, costOneKil: Float) {
        super.init(speed: speed, capacity: capacity, costOneKil: costOneKil)
    }
    override func transportation(enterNumberOfPassenger passangers: Int, distance: Int) {
        print("_____________")
        print("Flight")
        super.transportation(enterNumberOfPassenger: passangers, distance: distance)
    }
}
