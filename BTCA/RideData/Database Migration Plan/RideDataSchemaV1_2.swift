//
//  RideDataSchemaV1_2.swift
//  BTCA
//
//  Created by call151 on 2025-06-14.
//

import Foundation
import SwiftData

enum RideDataSchemaV1_2: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 2, 0)

    static var models: [any PersistentModel.Type] {
        [RideDataModel.self]
    }

    @Model
    class RideDataModel {
        var acceleration: Float
        var auxD: Float
        var batteryAh: Float
        var batteryLevelPercent: Float
        var batteryVolt: Float
        var batteryWattsHr: Float
        var consumptionA: Float
        var consumptionAH: Float
        var consumptionWatts: Float
        var consumptionWattsHr: Float
        var date: Date
        var distance: Float

        @Attribute(originalName: "flag")
        var flagToBeDeleted: Int16
        var tempFlagString:String = "0"
        
        var gpsDateTime: Date
        var gpsDirection: Double
        var gpsElevation: Double
        var gpsLatitude: Double
        var gpsLongitude: Double
        var gpsSpeed: Double
        var human: Int16
        var pasTorque: Float
        var rpm: Float
        var solarProductionA: Float
        var solarProductionAH: Float
        var solarProductionWatts: Float
        var solarProductionWattsHr: Float
        var speed: Float
        var throttleIN: Float
        var throttleOut: Float
        var tMotor: Float
        var wattsHrByKmAverage: Float
        var wattsHrByKmInstant: Float
        
        init() {
            self.acceleration = 0.0
            self.auxD = 0.0
            self.batteryAh = 0.0
            self.batteryLevelPercent = 0.0
            self.batteryVolt = 0.0
            self.batteryWattsHr = 0.0
            self.consumptionA = 0.0
            self.consumptionAH = 0.0
            self.consumptionWatts = 0.0
            self.consumptionWattsHr = 0.0
            self.date = Date()
            self.distance = 0.0
            
            self.flagToBeDeleted = 0
            self.tempFlagString = "0"
            
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
    
    
}
