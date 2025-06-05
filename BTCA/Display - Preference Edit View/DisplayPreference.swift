//
//  DisplayPreference.swift
//  MirrorChildTest
//
//  Created by call151 on 2025-03-20.
//

import Foundation
import SwiftUI

class DisplayPreference: Codable {
    var title       = [RideDataEnum: String]()           // title - top of Cell
    var unit        = [RideDataEnum: String]()           // unit - bottom of cell
    var precision   = [RideDataEnum: Int]()              // number of significant digit for display
    var position    = [RideDataEnum: Int]()               // position - position in collection view - good for re-ordernig too
    var color       = [RideDataEnum: ColorCodable]()     // color - Background color of cell

    static let shared: DisplayPreference = {
        return DisplayPreference.load()
        
    }()
    
    
    func setToDefault() {
        self.title      = titleDefault()
        self.unit       = unitDefault()
        self.precision  = precisionDefault()
        self.position   = positionDefault()
        self.color  = colorDefault()
    }
    
    func save() {
        print("***** DisplayPreference save +++++++++++++++++")
        do {
            let data = try JSONEncoder().encode(self)
            try data.write(to: DisplayPreference.getFileURL())
            print("DisplayPreference saved")
            
        } catch {
            print("Failed to save: \(error.localizedDescription)")
        }
    }
    
    static func load() -> DisplayPreference {
    
        let url = getFileURL()
        guard let data = try? Data(contentsOf: url),
              let loadedDisplayPreference = try? JSONDecoder().decode(DisplayPreference.self, from: data) else {
            let temp = DisplayPreference()
            temp.setToDefault()
            return temp // Return a default instance if the file doesn't exist
        }
        
        return loadedDisplayPreference
    }
    
    private static func getFileURL() -> URL {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: . userDomainMask).first else {
            fatalError("Could not retrieve document directory")
        }
        return documentDirectory.appendingPathComponent(BTCAConstant.displayPreferenceJSONFileName)
    }
    
    
//    var distanceEnum: DistanceEnum = .kilometers
//    var speedEnum: SpeedEnum = .kph
//    var tempEnum: TemperatureEnum = .celsius
    
    func titleDefault () -> [RideDataEnum: String]{
        var temp = [RideDataEnum: String]()
        
        temp[RideDataEnum.auxD] = "auxD"
        temp[RideDataEnum.batteryAh] = "batteryAh"
        temp[RideDataEnum.batteryLevelPercent] = "batteryLevel"
        temp[RideDataEnum.batteryVolt] = "batteryVolt"
        temp[RideDataEnum.batteryWattsHr] = "batteryWattsHr"
        temp[RideDataEnum.caTime] = "caTime"
        temp[RideDataEnum.consumptionA] = "consumptionA"
        temp[RideDataEnum.consumptionAH] = "consumptionAH"
        temp[RideDataEnum.consumptionWatts] =  "consumptionWatts"
        temp[RideDataEnum.consumptionWattsHr] = "consumptionWattsHr"
        temp[RideDataEnum.date] = "date"
        temp[RideDataEnum.distance] = "distance"
        temp[RideDataEnum.flag] = "flag"
        temp[RideDataEnum.gpsDateTime] = "gpsDateTime"
        temp[RideDataEnum.gpsDirection] = "gpsDirection"
        temp[RideDataEnum.gpsElevation] = "gpsElevation"
        temp[RideDataEnum.gpsLatitude] = "gpsLatitude"
        temp[RideDataEnum.gpsLongitude] = "gpsLongitude"
        temp[RideDataEnum.gpsSpeed] = "gpsSpeed"
        temp[RideDataEnum.human] = "human"
        temp[RideDataEnum.pasTorque] = "pasTorque"
        temp[RideDataEnum.rpm] = "rpm"
        temp[RideDataEnum.solarProductionA] = "solarProductionA"
        temp[RideDataEnum.solarProductionAH] = "solarProductionAH"
        temp[RideDataEnum.solarProductionWatts] = "solarProductionWatts"
        temp[RideDataEnum.solarProductionWattsHr] = "solarProductionWattsHr"
        temp[RideDataEnum.speed] = "speed"
        temp[RideDataEnum.throttleIN] = "throttleIN"
        temp[RideDataEnum.throttleOut] = "throttleOut"
        temp[RideDataEnum.tMotor] = "tMotor"
        temp[RideDataEnum.wattsHrByKmAverage] = "Average"
        temp[RideDataEnum.wattsHrByKmInstant] = "Inst"
        
        return temp
    }
    
    func unitDefault () -> [RideDataEnum: String]{
        var temp = [RideDataEnum: String]()
        
        let setup = Setup.shared
        
        
        temp[RideDataEnum.auxD] = "auxd"
        temp[RideDataEnum.batteryAh] = "Ah"
        temp[RideDataEnum.batteryLevelPercent] = "(P-C+Cor)/Cap"
        temp[RideDataEnum.batteryVolt] = "Volt"
        temp[RideDataEnum.batteryWattsHr] = "Watts*Hr"
        temp[RideDataEnum.caTime] = "caTime"
        temp[RideDataEnum.consumptionA] = "A"
        temp[RideDataEnum.consumptionAH] = "AH"
        temp[RideDataEnum.consumptionWatts] =  "Watts"
        temp[RideDataEnum.consumptionWattsHr] = "Watts*Hr"
        temp[RideDataEnum.date] = ""
        
        
        if setup.distanceEnum == DistanceEnum.kilometers {
            temp[RideDataEnum.distance] = DistanceEnum.kilometers.rawValue
        }
        else {
            temp[RideDataEnum.distance] = DistanceEnum.miles.rawValue
        }
            
        
        temp[RideDataEnum.flag] = " "
        temp[RideDataEnum.gpsDateTime] = "Date-Time"
        temp[RideDataEnum.gpsDirection] = "Heading"
        
        if setup.iPhoneEnum == IPhoneEnum.metric {
            temp[RideDataEnum.gpsElevation] = "meter"
        }
        else {
            temp[RideDataEnum.gpsElevation] = "feet"
        }
        

        temp[RideDataEnum.gpsLatitude] = "Degre"
        temp[RideDataEnum.gpsLongitude] = "Degre"

        if setup.iPhoneEnum == IPhoneEnum.metric {
            temp[RideDataEnum.gpsSpeed] = "km/h"
        }
        else {
            temp[RideDataEnum.gpsSpeed] = "m/h"
        }

        temp[RideDataEnum.human] = "N*m"
        temp[RideDataEnum.pasTorque] = "N*m"
        temp[RideDataEnum.rpm] = ""
        temp[RideDataEnum.solarProductionA] = "A"
        temp[RideDataEnum.solarProductionAH] = "AH"
        temp[RideDataEnum.solarProductionWatts] = "Watts"
        temp[RideDataEnum.solarProductionWattsHr] = "Watts*Hr"
        
        
        if setup.speedEnum == SpeedEnum.kph {
            temp[RideDataEnum.speed] = SpeedEnum.kph.rawValue
        }
        else {
            temp[RideDataEnum.speed] = SpeedEnum.mph.rawValue
        }
        
//        temp[RideDataEnum.speed] = "km/h"
        temp[RideDataEnum.throttleIN] = "Volt"
        temp[RideDataEnum.throttleOut] = "Volt"
        
        
        if setup.temperatureEnum == TemperatureEnum.celsius {
            temp[RideDataEnum.tMotor] = TemperatureEnum.celsius.rawValue
        }
        else {
            temp[RideDataEnum.tMotor] = TemperatureEnum.fahrenheit.rawValue
        }
        
//        temp[RideDataEnum.tMotor] = "Celcius"
        

        if setup.distanceEnum == DistanceEnum.kilometers {
            temp[RideDataEnum.wattsHrByKmAverage] = "watts*Hr/Km"
            temp[RideDataEnum.wattsHrByKmInstant] = "watts*Hr/Km"
        }
        else {
            temp[RideDataEnum.wattsHrByKmAverage] = "watts*Hr/Miles"
            temp[RideDataEnum.wattsHrByKmInstant] = "watts*Hr/Miles"
        }
        
        
        

        
        return temp
    }
    
    func precisionDefault () -> [RideDataEnum: Int]{
        var temp = [RideDataEnum: Int]()
        
        temp[RideDataEnum.auxD] = 0
        temp[RideDataEnum.batteryAh] = 1
        temp[RideDataEnum.batteryLevelPercent] = 0
        temp[RideDataEnum.batteryVolt] = 2
        temp[RideDataEnum.batteryWattsHr] = 0
        temp[RideDataEnum.caTime] = 0
        temp[RideDataEnum.consumptionA] = 2
        temp[RideDataEnum.consumptionAH] = 1
        temp[RideDataEnum.consumptionWatts] =  0
        temp[RideDataEnum.consumptionWattsHr] = 0
        temp[RideDataEnum.date] = 0
        temp[RideDataEnum.distance] = 1
        temp[RideDataEnum.flag] = 0
        temp[RideDataEnum.gpsDateTime] = 1
        temp[RideDataEnum.gpsDirection] = 1
        temp[RideDataEnum.gpsElevation] = 1
        temp[RideDataEnum.gpsLatitude] = 3
        temp[RideDataEnum.gpsLongitude] = 3
        temp[RideDataEnum.gpsSpeed] = 2
        temp[RideDataEnum.human] = 0
        temp[RideDataEnum.pasTorque] = 1
        temp[RideDataEnum.rpm] = 1
        temp[RideDataEnum.solarProductionA] = 2
        temp[RideDataEnum.solarProductionAH] = 1
        temp[RideDataEnum.solarProductionWatts] = 0
        temp[RideDataEnum.solarProductionWattsHr] = 0
        temp[RideDataEnum.speed] = 2
        temp[RideDataEnum.throttleIN] = 1
        temp[RideDataEnum.throttleOut] = 1
        temp[RideDataEnum.tMotor] = 1
        temp[RideDataEnum.wattsHrByKmAverage] = 2
        temp[RideDataEnum.wattsHrByKmInstant] = 2
        
        return temp
    }
    
    func positionDefault() -> [RideDataEnum: Int] {
        
        let setup = Setup.shared
        
        switch setup.firmwareType {
        case .Standard:
            return positionDefaultStandard()
        case .Alpha:
            return positionDefaultStandard()
        case .Beta:
            return positionDefaultStandard()
        case .Experimental:
            return positionDefaultStandard()
        case .Solar:
            return positionDefaultSolar()
//        default :
//            return positionDefaultStandard()
        }
    }
    
    func positionDefaultStandard() -> [RideDataEnum: Int] {
        var temp = [RideDataEnum: Int]()
        print ("Biz Standard ")
        temp[RideDataEnum.speed] = 0
        temp[RideDataEnum.batteryLevelPercent] = 1
        
        temp[RideDataEnum.consumptionA] = 2
        temp[RideDataEnum.consumptionAH] = 3

        temp[RideDataEnum.distance] = 4
        temp[RideDataEnum.date] = 5
        
        temp[RideDataEnum.wattsHrByKmAverage] = 6
        temp[RideDataEnum.wattsHrByKmInstant] = 7
        
        temp[RideDataEnum.batteryVolt] = 8
        temp[RideDataEnum.batteryAh] = 9
        
        temp[RideDataEnum.rpm] = 10
        temp[RideDataEnum.flag] = 11
        
        temp[RideDataEnum.throttleIN] = 12
        temp[RideDataEnum.throttleOut] = 13
        
        
        temp[RideDataEnum.auxD] = 14
        temp[RideDataEnum.caTime] = 15
        
        temp[RideDataEnum.batteryWattsHr] = 16
        temp[RideDataEnum.tMotor] = 17
        
        temp[RideDataEnum.consumptionWattsHr] = 18
        temp[RideDataEnum.consumptionWatts] = 19
        
        temp[RideDataEnum.gpsDirection] = 20
        temp[RideDataEnum.gpsElevation] = 21
        temp[RideDataEnum.gpsLatitude] = 22
        temp[RideDataEnum.gpsLongitude] = 23
        temp[RideDataEnum.gpsSpeed] = 24
        temp[RideDataEnum.gpsDateTime] = 25
        
        temp[RideDataEnum.human] = 26
        temp[RideDataEnum.pasTorque] = 27
        
        temp[RideDataEnum.solarProductionWatts] = 28
        temp[RideDataEnum.solarProductionA] = 29
        temp[RideDataEnum.solarProductionAH] = 30
        temp[RideDataEnum.solarProductionWattsHr] = 31

        
        return temp
    }
    
    
    func positionDefaultSolar() -> [RideDataEnum: Int] {
        var temp = [RideDataEnum: Int]()
 
        temp[RideDataEnum.speed] = 0
        temp[RideDataEnum.batteryLevelPercent] = 1
        
        temp[RideDataEnum.solarProductionWatts] = 2
        temp[RideDataEnum.consumptionWatts] = 3
        
        temp[RideDataEnum.solarProductionA] = 4
        temp[RideDataEnum.consumptionA] = 5
        
        temp[RideDataEnum.distance] = 6
        temp[RideDataEnum.date] = 7
        
        temp[RideDataEnum.solarProductionAH] = 8
        temp[RideDataEnum.consumptionAH] = 9
        
        temp[RideDataEnum.wattsHrByKmAverage] = 10
        temp[RideDataEnum.wattsHrByKmInstant] = 11
        
        temp[RideDataEnum.batteryVolt] = 12
        temp[RideDataEnum.batteryAh] = 13
        
        temp[RideDataEnum.rpm] = 14
        temp[RideDataEnum.flag] = 15
        
        temp[RideDataEnum.throttleIN] = 16
        temp[RideDataEnum.throttleOut] = 17
        
        
        temp[RideDataEnum.auxD] = 18
        temp[RideDataEnum.caTime] = 19
        
        temp[RideDataEnum.batteryWattsHr] = 20
        temp[RideDataEnum.tMotor] = 21
        
        temp[RideDataEnum.solarProductionWattsHr] = 22
        temp[RideDataEnum.consumptionWattsHr] = 23
        
        temp[RideDataEnum.gpsDirection] = 24
        temp[RideDataEnum.gpsElevation] = 25
        temp[RideDataEnum.gpsLatitude] = 26
        temp[RideDataEnum.gpsLongitude] = 27
        temp[RideDataEnum.gpsSpeed] = 28
        temp[RideDataEnum.gpsDateTime] = 29
        
        temp[RideDataEnum.human] = 30
        temp[RideDataEnum.pasTorque] = 31
        
        return temp
    }
    
    
    
    func colorDefault() -> [RideDataEnum: ColorCodable]{
        var temp = [RideDataEnum: ColorCodable]()
        
        var localColor = Color.brown
        var myCodableColor = ColorCodable(from: localColor)
        temp[RideDataEnum.auxD] = myCodableColor
        
        localColor = Color.yellow
        myCodableColor = ColorCodable(from: localColor)
        temp[RideDataEnum.batteryAh] = myCodableColor
        temp[RideDataEnum.batteryVolt] = myCodableColor
        temp[RideDataEnum.batteryWattsHr] = myCodableColor
        temp[RideDataEnum.batteryLevelPercent] = myCodableColor
        
        localColor = Color.red
        myCodableColor = ColorCodable(from: localColor)
        temp[RideDataEnum.consumptionA] = myCodableColor
        temp[RideDataEnum.consumptionAH] = myCodableColor
        temp[RideDataEnum.consumptionWatts] =  myCodableColor
        temp[RideDataEnum.consumptionWattsHr] = myCodableColor
        
        localColor = Color.blue
        myCodableColor = ColorCodable(from: localColor)
        temp[RideDataEnum.gpsDateTime] = myCodableColor
        temp[RideDataEnum.gpsDirection] = myCodableColor
        temp[RideDataEnum.gpsElevation] = myCodableColor
        temp[RideDataEnum.gpsLatitude] = myCodableColor
        temp[RideDataEnum.gpsLongitude] = myCodableColor
        temp[RideDataEnum.gpsSpeed] = myCodableColor
        
        localColor = Color.green
        myCodableColor = ColorCodable(from: localColor)
        temp[RideDataEnum.solarProductionA] = myCodableColor
        temp[RideDataEnum.solarProductionAH] = myCodableColor
        temp[RideDataEnum.solarProductionWatts] = myCodableColor
        temp[RideDataEnum.solarProductionWattsHr] = myCodableColor
        
        localColor = Color.white
        myCodableColor = ColorCodable(from: localColor)
        temp[RideDataEnum.date] = myCodableColor
        temp[RideDataEnum.distance] = myCodableColor
        temp[RideDataEnum.flag] = myCodableColor
        temp[RideDataEnum.human] = myCodableColor
        temp[RideDataEnum.pasTorque] = myCodableColor
        temp[RideDataEnum.rpm] = myCodableColor
        
        temp[RideDataEnum.speed] = myCodableColor
        temp[RideDataEnum.throttleIN] = myCodableColor
        temp[RideDataEnum.throttleOut] = myCodableColor
        
        temp[RideDataEnum.tMotor] = myCodableColor
        temp[RideDataEnum.wattsHrByKmAverage] = myCodableColor
        temp[RideDataEnum.wattsHrByKmInstant] = myCodableColor
        
        return temp
    }
    
}

