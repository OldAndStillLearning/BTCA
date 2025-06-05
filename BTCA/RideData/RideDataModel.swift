//
//  RideDataModel.swift
//  BTCA
//
//  Created by call151 on 2024-12-08.
//

import Foundation
import SwiftData

@Model
class RideDataModel {
    
    var auxD: Float = 0.0
    var batteryAh: Float = 0.0
    var batteryLevelPercent: Float  = 0.0
    var batteryVolt: Float = 0.0
    var batteryWattsHr: Float = 0.0
    var caTime: String = ""
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
    
    
    init() {
        self.auxD = 0.0
        self.batteryAh = 0.0
        self.batteryLevelPercent = 0.0
        self.batteryVolt = 0.0
        self.batteryWattsHr = 0.0
        self.caTime = "0"
        self.consumptionA = 0.0
        self.consumptionAH = 0.0
        self.consumptionWatts = 0.0
        self.consumptionWattsHr = 0.0
        self.date = Date()
        self.distance = 0.0
        self.flag = "1"
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
    
    

    func value(for variable: RideDataEnum) -> Double? {

        switch variable {
            // Float → cast to Double
        case .auxD: return Double(auxD)
        case .batteryAh: return Double(batteryAh)
        case .batteryLevelPercent: return Double(batteryLevelPercent)
        case .batteryVolt: return Double(batteryVolt)
        case .batteryWattsHr: return Double(batteryWattsHr)
        case .consumptionA: return Double(consumptionA)
        case .consumptionAH: return Double(consumptionAH)
        case .consumptionWatts: return Double(consumptionWatts)
        case .consumptionWattsHr: return Double(consumptionWattsHr)
        case .distance: return Double(distance)
        case .pasTorque: return Double(pasTorque)
        case .rpm: return Double(rpm)
        case .solarProductionA: return Double(solarProductionA)
        case .solarProductionAH: return Double(solarProductionAH)
        case .solarProductionWatts: return Double(solarProductionWatts)
        case .solarProductionWattsHr: return Double(solarProductionWattsHr)
        case .speed: return Double(speed)
        case .throttleIN: return Double(throttleIN)
        case .throttleOut: return Double(throttleOut)
        case .tMotor: return Double(tMotor)
        case .wattsHrByKmAverage: return Double(wattsHrByKmAverage)
        case .wattsHrByKmInstant: return Double(wattsHrByKmInstant)
            
            // Already Double
        case .gpsDirection: return gpsDirection
        case .gpsElevation: return gpsElevation
        case .gpsLatitude: return gpsLatitude
        case .gpsLongitude: return gpsLongitude
        case .gpsSpeed: return gpsSpeed
            
            // Skip Int16 and other unsupported
        default: return nil
        }
    }
    
    
    
    static func getARideDataInString(rideData: RideDataModel) -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        
        let line = [
            df.string(from: rideData.date),
            df.string(from: rideData.gpsDateTime),
            "\(rideData.auxD)",
            "\(rideData.batteryAh)",
            "\(rideData.batteryLevelPercent)",
            "\(rideData.batteryVolt)",
            "\(rideData.batteryWattsHr)",
            rideData.caTime,
            "\(rideData.consumptionA)",
            "\(rideData.consumptionAH)",
            "\(rideData.consumptionWatts)",
            "\(rideData.consumptionWattsHr)",
            "\(rideData.distance)",
            "\(rideData.flag)",
            "\(rideData.gpsDirection)",
            "\(rideData.gpsElevation)",
            "\(rideData.gpsLatitude)",
            "\(rideData.gpsLongitude)",
            "\(rideData.gpsSpeed)",
            "\(rideData.human)",
            "\(rideData.pasTorque)",
            "\(rideData.rpm)",
            "\(rideData.solarProductionA)",
            "\(rideData.solarProductionAH)",
            "\(rideData.solarProductionWatts)",
            "\(rideData.solarProductionWattsHr)",
            "\(rideData.speed)",
            "\(rideData.throttleIN)",
            "\(rideData.throttleOut)",
            "\(rideData.tMotor)",
            "\(rideData.wattsHrByKmAverage)",
            "\(rideData.wattsHrByKmInstant)"
        ].joined(separator: "\t")
        
        return line
    }
    
    
     
    static func getARideDataInString2(rideData: RideDataModel) -> String {  // TODO: REMOVE
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        
        let line = [
            df.string(from: rideData.date),
            df.string(from: rideData.gpsDateTime),
            "\(rideData.auxD)",
            "\(rideData.batteryAh)",
            "\(rideData.batteryLevelPercent)",
            "\(rideData.batteryVolt)",
            "\(rideData.batteryWattsHr)",
            rideData.caTime,
            "\(rideData.consumptionA)",
            "\(rideData.consumptionAH)",
            "\(rideData.consumptionWatts)",
            "\(rideData.consumptionWattsHr)",
            "\(rideData.distance)",
            "\(rideData.flag)",
            "\(rideData.gpsDirection)",
            "\(rideData.gpsElevation)",
            "\(rideData.gpsLatitude)",
            "\(rideData.gpsLongitude)",
            "\(rideData.gpsSpeed)",
            "\(rideData.human)",
            "\(rideData.pasTorque)",
            "\(rideData.rpm)",
            "\(rideData.solarProductionA)",
            "\(rideData.solarProductionAH)",
            "\(rideData.solarProductionWatts)",
            "\(rideData.solarProductionWattsHr)",
            "\(rideData.speed)",
            "\(rideData.throttleIN)",
            "\(rideData.throttleOut)",
            "\(rideData.tMotor)",
            "\(rideData.wattsHrByKmAverage)",
            "\(rideData.wattsHrByKmInstant)"
        ].joined(separator: "\t")
        
        return line
    }
    
    
    static func typeFromID(_ id: Int) -> RideDataEnum {
        switch id {
        case 0 : return RideDataEnum.auxD
        case 1 : return RideDataEnum.batteryAh
        case 2 : return RideDataEnum.batteryLevelPercent
        case 3 : return RideDataEnum.batteryVolt
        case 4 : return RideDataEnum.batteryWattsHr
        case 5 : return RideDataEnum.caTime
        case 6 : return RideDataEnum.consumptionA
        case 7 : return RideDataEnum.consumptionAH
        case 8 : return RideDataEnum.consumptionWatts
        case 9 : return RideDataEnum.consumptionWattsHr
        case 10 : return RideDataEnum.date
        case 11 : return RideDataEnum.distance
        case 12 : return RideDataEnum.flag
        case 13 : return RideDataEnum.gpsDateTime
        case 14 : return RideDataEnum.gpsDirection
        case 15 : return RideDataEnum.gpsElevation
        case 16 : return RideDataEnum.gpsLatitude
        case 17 : return RideDataEnum.gpsLongitude
        case 18 : return RideDataEnum.gpsSpeed
        case 19 : return RideDataEnum.human
        case 20 : return RideDataEnum.pasTorque
        case 21 : return RideDataEnum.rpm
        case 22 : return RideDataEnum.solarProductionA
        case 23 : return RideDataEnum.solarProductionAH
        case 24 : return RideDataEnum.solarProductionWatts
        case 25 : return RideDataEnum.solarProductionWattsHr
        case 26 : return RideDataEnum.speed
        case 27 : return RideDataEnum.throttleIN
        case 28 : return RideDataEnum.throttleOut
        case 29 : return RideDataEnum.tMotor
        case 30 : return RideDataEnum.wattsHrByKmAverage
        case 31 : return RideDataEnum.wattsHrByKmInstant
        default:
            return RideDataEnum.auxD
        }
    }
}
