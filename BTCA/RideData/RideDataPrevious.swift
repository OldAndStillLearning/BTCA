//
//  RideDataPrevious.swift
//  BTCA
//
//  Created by Call-151 on 2019-06-18.
//  Copyright © 2019 Call-151. All rights reserved.
//

import Foundation
import Swift

@Observable
class RideDataPrevious {

    var lastDateAndTime = Date()        // TODO: 2020 we need to check if between last time and now, if more that 5 minute, reset value and reset consomma Instant and average CAN WE ?
    
    var solarProductionWattsHrPrevious:Float = 0.0
    var solarProductionAhPrevious:Float = 0.0
    
    var consumptionWattsHrPrevious:Float = 0.0
    var consumptionAhPrevious:Float = 0.0
    
    var batteryWattsHrPrevious:Float = 0.0
    var batteryAhPrevious:Float = 0.0
    
    var solarProductionAH: Float = 0.0
    var consumptionAH: Float = 0.0
    
    var batteryLevelPercent: Float = 0.0

    func resetPreviousData(){
        
        solarProductionWattsHrPrevious = 0.0
        solarProductionAhPrevious = 0.0
        
        consumptionWattsHrPrevious = 0.0
        consumptionAhPrevious = 0.0
        
        batteryWattsHrPrevious = 0.0
        batteryAhPrevious = 0.0
        
        solarProductionAH = 0.0
        consumptionAH = 0.0
        
    }
    
    func checkTimeInterval()  {
        let currentDate = Date()
        let timeSinceLastData = currentDate.timeIntervalSince(lastDateAndTime)  // in second
       // print ("Current time \(currentDate.description)    interval since last  \(timeSinceLastData)")
        
        //TODO: 30 seconds without data mean (hopefully) that we are starting a to receive, so  we should reset
        if timeSinceLastData > 30 {
            resetPreviousData()
        }
        lastDateAndTime = currentDate
    }
    
    
}
