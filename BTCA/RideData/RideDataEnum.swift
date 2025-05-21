//
//  RideDataEnum.swift
//  BTCA
//
//  Created by call151 on 2025-03-18.
//

import Foundation

enum RideDataEnum:String, Codable, CaseIterable, Identifiable {
    var id: Int { rawValue.hashValue }
    
    case
    auxD = "auxD",
    batteryAh = "batteryAh",
    batteryLevelPercent = "batteryLevelPercent",
    batteryVolt = "batteryVolt",
    batteryWattsHr = "batteryWattsHr",
    caTime = "caTime",
    consumptionA = "consumptionA",
    consumptionAH = "consumptionAH",
    consumptionWatts = "consumptionWatts",
    consumptionWattsHr = "consumptionWattsHr",
    date = "date",
    distance = "distance",
    flag = "flag",
    gpsDateTime = "gpsDateTime",
    gpsDirection = "gpsDirection",
    gpsElevation = "gpsElevation",
    gpsLatitude = "gpsLatitude",
    gpsLongitude = "gpsLongitude",
    gpsSpeed = "gpsSpeed",
    human = "human",
    pasTorque = "pasTorque",
    rpm = "rpm",
    solarProductionA = "solarProductionA",
    solarProductionAH = "solarProductionAH",
    solarProductionWatts = "solarProductionWatts",
    solarProductionWattsHr = "solarProductionWattsHr",
    speed = "speed",
    throttleIN = "throttleIN",
    throttleOut = "throttleOut",
    tMotor = "tMotor",
    wattsHrByKmAverage = "wattsHrByKmAverage",
    wattsHrByKmInstant = "wattsHrByKmInstant"
    
    var intValue: Int {
        switch self {
        case .auxD : return 0
        case .batteryAh : return 1
        case .batteryLevelPercent : return 2
        case .batteryVolt : return 3
        case .batteryWattsHr : return 4
        case .caTime : return 5
        case .consumptionA : return 6
        case .consumptionAH : return 7
        case .consumptionWatts : return 8
        case .consumptionWattsHr : return 9
        case .date : return 10
        case .distance : return 11
        case .flag : return 12
        case .gpsDateTime : return 13
        case .gpsDirection : return 14
        case .gpsElevation : return 15
        case .gpsLatitude : return 16
        case .gpsLongitude : return 17
        case .gpsSpeed : return 18
        case .human : return 19
        case .pasTorque : return 20
        case .rpm : return 21
        case .solarProductionA : return 22
        case .solarProductionAH : return 23
        case .solarProductionWatts : return 24
        case .solarProductionWattsHr : return 25
        case .speed : return 26
        case .throttleIN : return 27
        case .throttleOut : return 28
        case .tMotor : return 29
        case .wattsHrByKmAverage : return 30
        case .wattsHrByKmInstant : return 31
        }
    }
    
    
    
    var nameText: String {
        switch self {
            
        case .auxD: return "auxD"
        case .batteryAh: return "batteryAh"
        case .batteryLevelPercent: return "batteryLevelPercent"
        case .batteryVolt: return "batteryVolt"
        case .batteryWattsHr: return "batteryWattsHr"
        case .caTime: return "caTime"
        case .consumptionA: return "consumptionA"
        case .consumptionAH: return "consumptionAH"
        case .consumptionWatts: return "consumptionWatts"
        case .consumptionWattsHr: return "consumptionWattsHr"
        case .date: return "date"
        case .distance: return "distance"
        case .flag: return "flag"
        case .gpsDateTime: return "gpsDateTime"
        case .gpsDirection: return "gpsDirection"
        case .gpsElevation: return "gpsElevation"
        case .gpsLatitude: return "gpsLatitude"
        case .gpsLongitude: return "gpsLongitude"
        case .gpsSpeed: return "gpsSpeed"
        case .human: return "human"
        case .pasTorque: return "pasTorque"
        case .rpm: return "rpm"
        case .solarProductionA: return "solarProductionA"
        case .solarProductionAH: return "solarProductionAH"
        case .solarProductionWatts: return "solarProductionWatts"
        case .solarProductionWattsHr: return "solarProductionWattsHr"
        case .speed: return "speed"
        case .throttleIN: return "throttleIN"
        case .throttleOut: return "throttleOut"
        case .tMotor: return "tMotor"
        case .wattsHrByKmAverage: return "wattsHrByKmAverage"
        case .wattsHrByKmInstant: return "wattsHrByKmInstant"
        }
    }
    
    // for Chart
        var isNumericFloatOrDouble: Bool {
            switch self {
                // Float types
            case .auxD, .batteryAh, .batteryLevelPercent, .batteryVolt, .batteryWattsHr,
                    .consumptionA, .consumptionAH, .consumptionWatts, .consumptionWattsHr,
                    .distance, .pasTorque, .rpm, .solarProductionA, .solarProductionAH,
                    .solarProductionWatts, .solarProductionWattsHr, .speed,
                    .throttleIN, .throttleOut, .tMotor, .wattsHrByKmAverage, .wattsHrByKmInstant:
                return true
                // Double types
            case .gpsDirection, .gpsElevation, .gpsLatitude, .gpsLongitude, .gpsSpeed:
                return true
            default:
                return false
            }
        }
    
    
    static func titleForRawData(setup: Setup) -> String {
        var line: [String] = [String]()
        let config = setup.firmwareVersion.returnDataConfiguration()
        line.append("Date")
        
        for key in config.keys.sorted() {
            if let rideData = config[key] {
                line.append(rideData.nameText)
            }
        }
        
        return line.joined(separator: "\t")
    }
    
    
    
    static func titleForAllData() -> String {
        let line = [
            RideDataEnum.date.nameText,
            RideDataEnum.gpsDateTime.nameText,
            RideDataEnum.auxD.nameText,
            RideDataEnum.batteryAh.nameText,
            RideDataEnum.batteryLevelPercent.nameText,
            RideDataEnum.batteryVolt.nameText,
            RideDataEnum.batteryWattsHr.nameText,
            RideDataEnum.caTime.nameText,
            RideDataEnum.consumptionA.nameText,
            RideDataEnum.consumptionAH.nameText,
            RideDataEnum.consumptionWatts.nameText,
            RideDataEnum.consumptionWattsHr.nameText,
            RideDataEnum.distance.nameText,
            RideDataEnum.flag.nameText,
            RideDataEnum.gpsDirection.nameText,
            RideDataEnum.gpsElevation.nameText,
            RideDataEnum.gpsLatitude.nameText,
            RideDataEnum.gpsLongitude.nameText,
            RideDataEnum.gpsSpeed.nameText,
            RideDataEnum.human.nameText,
            RideDataEnum.pasTorque.nameText,
            RideDataEnum.rpm.nameText,
            RideDataEnum.solarProductionA.nameText,
            RideDataEnum.solarProductionAH.nameText,
            RideDataEnum.solarProductionWatts.nameText,
            RideDataEnum.solarProductionWattsHr.nameText,
            RideDataEnum.speed.nameText,
            RideDataEnum.throttleIN.nameText,
            RideDataEnum.throttleOut.nameText,
            RideDataEnum.tMotor.nameText,
            RideDataEnum.wattsHrByKmAverage.nameText,
            RideDataEnum.wattsHrByKmInstant.nameText
        ].joined(separator: "\t")
        
        return line
    }
}
