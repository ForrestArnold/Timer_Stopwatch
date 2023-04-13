//
//  Clock.swift
//  timer
//
//  Created by Student on 4/11/23.
//

import Foundation

struct MyClock {
    var minTime: Int
    var maxTime: Int
    var startingTime = 100
    
    init(minTime: Int = 1, maxTime: Int = 50, startingTime: Int = 100) {
        self.minTime = minTime
        self.maxTime = maxTime
        self.startingTime = startingTime
    }
    
    func updateCounting() {
        print("Counting...")
    }
}
