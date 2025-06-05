//
//  LimitFlagEnum.swift
//  BTCA
//
//  Created by call151 on 2025-06-05.
//

import Foundation


enum LimitFlagEnum:String, Codable, CaseIterable, Identifiable {
    var id: Int { rawValue.hashValue }
    
    case
    Preset1 = "Preset 1",
    Preset2 = "Preset 2",
    Preset3 = "Preset 3",
    ThrottleFault  = "ThrottleFault",
    Brake = "Brake",
    AmpLimiting = "Amp Limiting",
    WattsLimiting = "Watts Limiting",
    TempLimiting = "Temp Limiting",
    LowVoltsLimiting = "Low Volts Limiting",
    SpeedLimiting = "Speed Limiting",
    LowSpeedLimiting = "Low Speed Limiting"
    
    
    var nameText: String {
        switch self {
        case .Preset1: return "Preset 1"
        case .Preset2: return "Preset 2"
        case .Preset3: return "Preset 3"
        case .ThrottleFault : return "ThrottleFault"
        case .Brake: return "Brake"
        case .AmpLimiting: return "Amp limiting"
        case .WattsLimiting: return "Watts Limiting"
        case .TempLimiting: return "Temp Limiting"
        case .LowVoltsLimiting: return "Low Volts Limiting"
        case .SpeedLimiting: return "Speed Limiting"
        case .LowSpeedLimiting: return "Low Speed Limiting"
        }
    }
    
    
    
    func whichFlag (letter: String) -> LimitFlagEnum {
        
        switch letter {
        case "1":
            return .Preset1
        case "2":
            return .Preset2
        case "3":
            return .Preset3
        case "X":
            return .ThrottleFault
        case "B":
            return .Brake
        case "A":
            return .AmpLimiting
        case "W":
            return .WattsLimiting
        case "T":
            return .TempLimiting
        case "V":
            return .LowVoltsLimiting
        case "S":
            return .SpeedLimiting
        case "s":
            return .LowSpeedLimiting
            
        default :
            return .Preset1
            
        }
        
    }
    
    
}


