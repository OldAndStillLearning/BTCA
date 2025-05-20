//
//  BTCAVarGroup.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-05-04.
//

import Foundation

enum BTCAVarGroup: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    
    case production = "Production"
    case consumption = "Consumption"
    case gps = "GPS"
    case battery = "Battery"
    
    var variables: [RideDataEnum] {
        switch self {
        case .production:
            return [.solarProductionA, .solarProductionAH, .solarProductionWatts, .solarProductionWattsHr]
        case .consumption:
            return [.consumptionA, .consumptionAH, .consumptionWatts, .consumptionWattsHr]
        case .gps:
            return [.gpsDateTime, .gpsDirection, .gpsElevation, .gpsLatitude, .gpsLongitude, .gpsSpeed]
        case .battery:
            return [.batteryAh, .batteryLevelPercent, .batteryVolt, .batteryWattsHr]
        }
    }
}
