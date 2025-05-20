//
//  MetricOrStandardEnum.swift
//  BTCA
//
//  Created by call151 on 2025-05-19.
//

import Foundation



enum DistanceEnum: String, CaseIterable, Codable, Identifiable {
    case kilometers = "kilometers"
    case miles = "miles"

    var id: String { rawValue }
}


enum SpeedEnum: String, CaseIterable, Codable, Identifiable {
    case kph = "km/hr"
    case mph = "m/h"

    var id: String { rawValue }
}


enum TemperatureEnum: String, CaseIterable, Codable, Identifiable {
    case celsius = "celsius"
    case fahrenheit = "fahrenheit"

    var id: String { rawValue }
}

enum IPhoneEnum: String, CaseIterable, Codable, Identifiable {
    case metric = "metric"
    case standard = "standard"

    var id: String { rawValue }
}


//enum CellStyle: Int, CaseIterable, Identifiable {
//    case basic, compact, detailed
//    
//    var id: Int { rawValue }
//
//    var name: String {
//        switch self {
//        case .basic: return "Basic"
//        case .compact: return "Compact"
//        case .detailed: return "Detailed"
//        }
//    }
//
//    static func loadFromUserDefaults() -> CellStyle {
//        let rawValue = UserDefaults.standard.integer(forKey: "CellDisplayStyle")
//        return CellStyle(rawValue: rawValue) ?? .basic
//    }
//
//    func saveToUserDefaults() {
//        UserDefaults.standard.set(rawValue, forKey: "CellDisplayStyle")
//    }
//}
