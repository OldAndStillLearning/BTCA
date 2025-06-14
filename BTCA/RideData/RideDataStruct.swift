//
//  RideDataStruct.swift
//  MirrorChildTest
//
//  Created by call151 on 2025-03-19.
//

import Foundation

struct RideDataStruct {
    
    var auxD: Float = 0.0
    var batteryAh: Float = 0.0
    var batteryLevelPercent: Float  = 0.0
    var batteryVolt: Float = 0.0
    var batteryWattsHr: Float = 0.0
    var acceleration: Float = 0.0
    var consumptionA: Float = 0.0
    var consumptionAH: Float = 0.0
    var consumptionWatts: Float = 0.0
    var consumptionWattsHr: Float = 0.0
    var date: Date = Date()
    var distance: Float = 0.0
    var flag: String  = ""
    var gpsDateTime: Date = Date()
    var gpsDirection: Double = 0.0
    var gpsElevation: Double = 0.0
    var gpsLatitude: Double = 0.0
    var gpsLongitude: Double = 0.0
    var gpsSpeed: Double = 0.0
    var human: Int16 = 0
    var pasTorque: Float = 0.0
    var rpm: Float = 0.0
    var solarProductionA: Float = 0.0
    var solarProductionAH: Float = 0.0
    var solarProductionWatts: Float = 0.0
    var solarProductionWattsHr: Float  = 0.0
    var speed: Float = 0.0
    var throttleIN: Float = 0.0
    var throttleOut: Float = 0.0
    var tMotor: Float = 0.0
    var wattsHrByKmAverage: Float = 0.0
    var wattsHrByKmInstant: Float = 0.0
    
    
    init(rideData: RideDataModel) {
        self.auxD = rideData.auxD
        self.batteryAh = rideData.batteryAh
        self.batteryLevelPercent = rideData.batteryLevelPercent
        self.batteryVolt = rideData.batteryVolt
        self.batteryWattsHr = rideData.batteryWattsHr
        self.acceleration = rideData.acceleration
        self.consumptionA = rideData.consumptionA
        self.consumptionAH = rideData.consumptionAH
        self.consumptionWatts = rideData.consumptionWatts
        self.consumptionWattsHr = rideData.consumptionWattsHr
        self.date = rideData.date
        self.distance = rideData.distance
        self.flag = rideData.flag
        self.gpsDateTime = rideData.gpsDateTime
        self.gpsDirection = rideData.gpsDirection
        self.gpsElevation = rideData.gpsElevation
        self.gpsLatitude = rideData.gpsLatitude
        self.gpsLongitude = rideData.gpsLongitude
        self.gpsSpeed = rideData.gpsSpeed
        self.human = rideData.human
        self.pasTorque = rideData.pasTorque
        self.rpm = rideData.rpm
        self.solarProductionA = rideData.solarProductionA
        self.solarProductionAH = rideData.solarProductionAH
        self.solarProductionWatts = rideData.solarProductionWatts
        self.solarProductionWattsHr = rideData.solarProductionWattsHr
        self.speed = rideData.speed
        self.throttleIN = rideData.throttleIN
        self.throttleOut = rideData.throttleOut
        self.tMotor = rideData.tMotor
        self.wattsHrByKmAverage = rideData.wattsHrByKmAverage
        self.wattsHrByKmInstant = rideData.wattsHrByKmInstant
    }
    
    
    init() {
        self.auxD = 0.0
        self.batteryAh = 0.0
        self.batteryLevelPercent = 0.0
        self.batteryVolt = 0.0
        self.batteryWattsHr = 0.0
        self.acceleration = 0.0
        self.consumptionA = 0.0
        self.consumptionAH = 0.0
        self.consumptionWatts = 0.0
        self.consumptionWattsHr = 0.0
        self.date = Date()
        self.distance = 0.0
        self.flag = "Preset 1"
        self.gpsDateTime = Date()
        self.gpsDirection = 0.0
        self.gpsElevation = 0.0
        self.gpsLatitude = 0.0
        self.gpsLongitude = 0.0
        self.gpsSpeed = 0.0
        self.human = 0
        self.pasTorque = 0.0
        self.rpm = 0.0
        self.solarProductionA = 0.0
        self.solarProductionAH = 0.0
        self.solarProductionWatts = 0.0
        self.solarProductionWattsHr = 0.0
        self.speed = 0.0
        self.throttleIN = 0.0
        self.throttleOut = 0.0
        self.tMotor = 0.0
        self.wattsHrByKmAverage = 0.0
        self.wattsHrByKmInstant = 0.0
    }
}
