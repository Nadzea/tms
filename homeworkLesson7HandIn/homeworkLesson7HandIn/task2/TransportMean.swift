//
//  TransportMean.swift
//  homeworkLesson7HandIn
//
//  Created by Надежда Клименко on 5.07.21.
//

import Foundation


class TransportMean {
    var speed: Int
    let capacity: Int
    var costOneKil: Float
    
    init(speed: Int, capacity: Int, costOneKil: Float) {
        self.speed = speed
        self.capacity = capacity
        self.costOneKil = costOneKil
    }
    
    func transportation(enterNumberOfPassenger passangers: Int, distance: Int) {
        let time: Float = Float(distance) / Float(speed)
        let cost: Float = Float(distance) * costOneKil
        let numberOfTransportMeans: Float = Float(passangers) / Float(capacity)
        print("Travel time: \(time) hour(s)")
        print("The cost of the trip: \(cost) EUR")
        print("Required number of transport means: \(numberOfTransportMeans.rounded(.awayFromZero))")
    }
}
