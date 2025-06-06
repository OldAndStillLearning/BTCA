//
//  BTCAConstant.swift
//  page Acceuil
//
//  Created by call151 on 2025-01-25.
//

import Foundation

struct BTCAConstant {

    // Setup Section
    static let setupJSONFileName    = "setup.json"
    static let batteryMinimum       = 1.0
    static let batteryMaximum       = 250.0

    // Display Preference
    static let displayPreferenceJSONFileName = "displayPreference.json"
    
    // Text Cruncher
    static let eolUnicodeString: Character = "\r"
    
    
    // TODO: changeable be interface (but with min max to avoid error
    static let NUMBER_OF_DATA_TO_CALCULATED_AVERAGE_CONSUMPTION   = 100  // 1 second per data   1 min 40 secon
    static let NUMBER_OF_DATA_TO_CALCULATED_INSTANT_CONSUMPTION   = 10    // average on 10 second for instant consumption

    static let auxD = "auxD"
    static let batteryAh = "batteryAh"
    static let batteryLevelPercent = "batteryLevelPercent"
    static let batteryVolt = "batteryVolt"
    static let batteryWattsHr = "batteryWattsHr"
    static let acceleration = "acceleration"
    static let consumptionA = "consumptionA"
    static let consumptionAH = "consumptionAH"
    static let consumptionWatts = "consumptionWatts"
    static let consumptionWattsHr = "consumptionWattsHr"
    static let date = "date"
    static let distance = "distance"
    static let flag = "flag"
    static let gpsDateTime = "gpsDateTime"
    static let gpsDirection = "gpsDirection"
    static let gpsElevation = "gpsElevation"
    static let gpsLatitude = "gpsLatitude"
    static let gpsLongitude = "gpsLongitude"
    static let gpsSpeed = "gpsSpeed"
    static let human = "human"
    static let pasTorque = "pasTorque"
    static let rpm = "rpm"
    static let solarProductionA = "solarProductionA"
    static let solarProductionAH = "solarProductionAH"
    static let solarProductionWatts = "solarProductionWatts"
    static let solarProductionWattsHr = "solarProductionWattsHr"
    static let speed = "speed"
    static let throttleIN = "throttleIN"
    static let throttleOut = "throttleOut"
    static let tMotor = "tMotor"
    static let wattsHrByKmAverage = "wattsHrByKmAverage"
    static let wattsHrByKmInstant = "wattsHrByKmInstant"
    
    
    static func whichBTCAVar(aText: String) -> RideDataEnum {
        
        switch aText {
            
        case BTCAConstant.auxD: return RideDataEnum.auxD
        case BTCAConstant.batteryAh: return RideDataEnum.batteryAh
        case BTCAConstant.batteryLevelPercent: return RideDataEnum.batteryLevelPercent
        case BTCAConstant.batteryVolt: return RideDataEnum.batteryVolt
        case BTCAConstant.batteryWattsHr: return RideDataEnum.batteryWattsHr
        case BTCAConstant.acceleration: return RideDataEnum.acceleration
        case BTCAConstant.consumptionA: return RideDataEnum.consumptionA
        case BTCAConstant.consumptionAH: return RideDataEnum.consumptionAH
        case BTCAConstant.consumptionWatts: return RideDataEnum.consumptionWatts
        case BTCAConstant.consumptionWattsHr: return RideDataEnum.consumptionWattsHr
        case BTCAConstant.date: return RideDataEnum.date
        case BTCAConstant.distance: return RideDataEnum.distance
        case BTCAConstant.flag: return RideDataEnum.flag
        case BTCAConstant.gpsDateTime: return RideDataEnum.gpsDateTime
        case BTCAConstant.gpsDirection: return RideDataEnum.gpsDirection
        case BTCAConstant.gpsElevation: return RideDataEnum.gpsElevation
        case BTCAConstant.gpsLatitude: return RideDataEnum.gpsLatitude
        case BTCAConstant.gpsLongitude: return RideDataEnum.gpsLongitude
        case BTCAConstant.gpsSpeed: return RideDataEnum.gpsSpeed
        case BTCAConstant.human: return RideDataEnum.human
        case BTCAConstant.pasTorque: return RideDataEnum.pasTorque
        case BTCAConstant.rpm: return RideDataEnum.rpm
        case BTCAConstant.solarProductionA: return RideDataEnum.solarProductionA
        case BTCAConstant.solarProductionAH: return RideDataEnum.solarProductionAH
        case BTCAConstant.solarProductionWatts: return RideDataEnum.solarProductionWatts
        case BTCAConstant.solarProductionWattsHr: return RideDataEnum.solarProductionWattsHr
        case BTCAConstant.speed: return RideDataEnum.speed
        case BTCAConstant.throttleIN: return RideDataEnum.throttleIN
        case BTCAConstant.throttleOut: return RideDataEnum.throttleOut
        case BTCAConstant.tMotor: return RideDataEnum.tMotor
        case BTCAConstant.wattsHrByKmAverage: return RideDataEnum.wattsHrByKmAverage
        case BTCAConstant.wattsHrByKmInstant: return RideDataEnum.wattsHrByKmInstant
            
        default : return RideDataEnum.auxD
        }
        
        
    }
    
}


