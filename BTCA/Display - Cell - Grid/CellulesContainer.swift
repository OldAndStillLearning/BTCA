//
//  CellulesContainer.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-03-24.
//

import Foundation
import SwiftUI

@Observable
class CellulesContainer {
    var cellules: [Cellule] = []
    var demoData: [Cellule] = []

    init() {
        self.demoData = demoCellules()
    }

    func demoCellules() -> [Cellule] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .medium
        let dateEnString = dateFormatter.string(from: Date())
        
        let tempDemoData = [
            Cellule(id: 0, position: 18, valueToDisplay: "0" , color: .brown, title: "AuxD", unit: "auxd"),
            Cellule(id: 1, position: 13, valueToDisplay: "1" , color: .yellow, title: "BattAH", unit: "Ah"),
            Cellule(id: 2, position: 1, valueToDisplay: "2" , color: .yellow, title: "Batt %", unit: "%"),
            Cellule(id: 3, position: 12, valueToDisplay: "3" , color: .yellow, title: "BattV", unit: "Volts"),
            Cellule(id: 4, position: 20, valueToDisplay: "4" , color: .yellow, title: "batteryWattsHr", unit: "Whr"),
            Cellule(id: 5, position: 19, valueToDisplay: dateEnString, color: .red, title: "Time", unit: "CATime"),
            Cellule(id: 6, position: 5, valueToDisplay: "56" , color: .red, title: "ConsumptionA", unit: "Amperes"),
            Cellule(id: 7, position: 9, valueToDisplay: "7" , color: .red, title: "consumptionAH", unit: "AH"),
            Cellule(id: 8, position: 3, valueToDisplay: "8" , color: .red, title: "Consumption", unit: "Watss"),
            Cellule(id: 9, position: 23, valueToDisplay: "9" , color: .red, title: "consumptionWattsHr", unit: "WattsHr"),
            Cellule(id: 10, position: 7, valueToDisplay: "10" , color: .white, title: "date", unit: "jour"),
            Cellule(id: 11, position: 6, valueToDisplay: "11" , color: .white, title: "Distance", unit: "km"),
            Cellule(id: 12, position: 15, valueToDisplay: "12" , color: .white, title: "flag", unit: "unit"),
            Cellule(id: 13, position: 29, valueToDisplay: "13" , color: .blue, title: "gpsDateTime", unit: "gps date"),
            Cellule(id: 14, position: 24, valueToDisplay: "14" , color: .blue, title: "gpsDirection", unit: "gps Heading"),
            Cellule(id: 15, position: 25, valueToDisplay: "15" , color: .blue, title: "gpsElevation", unit: "gps ele"),
            Cellule(id: 16, position: 26, valueToDisplay: "16" , color: .blue, title: "gpsLatitude", unit: "gps lat"),
            Cellule(id: 17, position: 27, valueToDisplay: "17" , color: .blue, title: "gpsLongitude", unit: "gps long"),
            Cellule(id: 18, position: 28, valueToDisplay: "18" , color: .blue, title: "gpsSpeed", unit: "gps km/hr"),
            Cellule(id: 19, position: 30, valueToDisplay: "19" , color: .white, title: "human", unit: "N*m"),
            Cellule(id: 20, position: 31, valueToDisplay: "20" , color: .white, title: "pasTorque", unit: "N*m"),
            Cellule(id: 21, position: 14, valueToDisplay: "21" , color: .white, title: "RPM", unit: "rpm"),
            Cellule(id: 22, position: 4, valueToDisplay: "22" , color: .green, title: "ProductionA", unit: "Amperes"),
            Cellule(id: 23, position: 8, valueToDisplay: "23" , color: .green, title: "solarProductionAH", unit: "Ah"),
            Cellule(id: 24, position: 2, valueToDisplay: "24" , color: .green, title: "Production", unit: "Watts"),
            Cellule(id: 25, position: 22, valueToDisplay: "25" , color: .green, title: "solarProductionWattsHr", unit: "WattsHr"),
            Cellule(id: 26, position: 0, valueToDisplay: "26" , color: .white, title: "Speed", unit: "km/hr"),
            Cellule(id: 27, position: 16, valueToDisplay: "27" , color: .white, title: "throttleIN", unit: "Volts"),
            Cellule(id: 28, position: 17, valueToDisplay: "28" , color: .white, title: "throttleOut", unit: "Volts"),
            Cellule(id: 29, position: 21, valueToDisplay: "29" , color: .white, title: "T motor", unit: "Celcius"),
            Cellule(id: 30, position: 10, valueToDisplay: "30" , color: .white, title: "wattsHrByKmAverage", unit: "Wh/km"),
            Cellule(id: 31, position: 11, valueToDisplay: "31" , color: .white, title: "wattsHrByKmInstant", unit: "Wh/km"),
        ]
        return tempDemoData
    }
}
