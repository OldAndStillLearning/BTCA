//
//  RideDataDisplayStyle.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-03-26.
//

import Foundation

enum CellStyle: Int, CaseIterable, Identifiable {
    case basic, compact, detailed
    
    var id: Int { rawValue }

    var name: String {
        switch self {
        case .basic: return "Basic"
        case .compact: return "Compact"
        case .detailed: return "Detailed"
        }
    }

    static func loadFromUserDefaults() -> CellStyle {
        let rawValue = UserDefaults.standard.integer(forKey: "CellDisplayStyle")
        return CellStyle(rawValue: rawValue) ?? .basic
    }

    func saveToUserDefaults() {
        UserDefaults.standard.set(rawValue, forKey: "CellDisplayStyle")
    }
}
