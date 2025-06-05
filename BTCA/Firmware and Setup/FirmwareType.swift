//
//  FirmwareType.swift
//  page Acceuil
//
//  Created by call151 on 2025-01-23.
//

import Foundation

enum FirmwareType:String, CaseIterable, Codable, Identifiable {
    var id: String { rawValue }
    
    case Standard = "Standard", Alpha = "Alpha", Beta = "Beta", Experimental = "Experimental", Solar = "Solar"
    
    func shortName() ->String{
        switch self {
        case .Standard:
            return "STD"
            
        case .Alpha:
            return "Alpha"
            
        case .Beta:
            return "Beta"
            
        case .Experimental:
            return "Exp."
            
        case .Solar:
            return "Solar"
            
        }
    }

    
    func simulationData() ->  [String] {
        
        switch self {
            
        case FirmwareType.Solar:
            var uneArray = Array(repeating: "", count: 15)
            uneArray[0] = ("2.8833")        //Pos  0 - > BTCAVar.consumptionAH       Float
            uneArray[1] = ("48.14")         //Pos  1 - > BTCAVar.batteryVolt         Float
            uneArray[2] = ("3.109")         //Pos  2 - > BTCAVar.consumptionA        Float
            uneArray[3] = ("17.4")          //Pos  3 - > BTCAVar.speed               Float
            uneArray[4] = ("124.5333")      //Pos  4 - > BTCAVar.distance            Float
            uneArray[5] = ("55.0")          //Pos  5 - > BTCAVar.tMotor              Float
            uneArray[6] = ("77.2")          //Pos  6 - > BTCAVar.rpm                 Float
            uneArray[7] = ("6")             //Pos  7 - > BTCAVar.human               Int
            uneArray[8] = ("3.3")           //Pos  8 - > BTCAVar.pasTorque           Float
            uneArray[9] = ("3.7")           //Pos  9 - > BTCAVar.throttleIN          Float
            uneArray[10] = ("0.99")         //Pos 10 - > BTCAVar.throttleOut        Float
            uneArray[11] = ("3.444")        //Pos 11 - > BTCAVar.auxD               Float
            uneArray[12] = ("23.73")        //Pos 12 - > BTCAVar.solarProductionAH  Float
            uneArray[13] = ("2.1")          //Pos 13 - > BTCAVar.solarProductionA   Float
            uneArray[14] = ("X")            //Pos 14 - > BTCAVar.flag               Int
            return uneArray
            
        default:
            var uneArray = Array(repeating: "", count: 14)
            uneArray[0] = ("2.8833")        //Pos  0 - > BTCAVar.consumptionAH       Float
            uneArray[1] = ("48.14")         //Pos  1 - > BTCAVar.batteryVolt         Float
            uneArray[2] = ("3.109")         //Pos  2 - > BTCAVar.consumptionA        Float
            uneArray[3] = ("17.4")          //Pos  3 - > BTCAVar.speed               Float
            uneArray[4] = ("124.5333")      //Pos  4 - > BTCAVar.distance            Float
            uneArray[5] = ("55.0")          //Pos  5 - > BTCAVar.tMotor              Float
            uneArray[6] = ("77.2")          //Pos  6 - > BTCAVar.rpm                 Float
            uneArray[7] = ("6")             //Pos  7 - > BTCAVar.human               Int
            uneArray[8] = ("3.3")           //Pos  8 - > BTCAVar.pasTorque           Float
            uneArray[9] = ("3.7")           //Pos  9 - > BTCAVar.throttleIN          Float
            uneArray[10] = ("0.99")         //Pos 10 - > BTCAVar.throttleOut        Float
            uneArray[11] = ("3.444")        //Pos 11 - > BTCAVar.auxD               Float
            uneArray[12] = ("2.73")        //Pos 12 - > BTCAVar.solarProduction  Float //TODO: pas la bonne car existe pas encore
            uneArray[13] = ("B")            //Pos 14 - > BTCAVar.flag               Int
            
            return uneArray
        }
    }
    
    
    
//    func simulationData2(firmwareType: FirmwareType) ->  [String] {
//
//        switch firmwareType {
//
//        case FirmwareType.Solar:
//            var uneArray = [String]()
//            uneArray[0] = ("2.8833")        //Pos  0 - > BTCAVar.consumptionAH       Float
//            uneArray[1] = ("48.14")         //Pos  1 - > BTCAVar.batteryVolt         Float
//            uneArray[2] = ("3.109")         //Pos  2 - > BTCAVar.consumptionA        Float
//            uneArray[3] = ("17.4")          //Pos  3 - > BTCAVar.speed               Float
//            uneArray[4] = ("124.5333")      //Pos  4 - > BTCAVar.distance            Float
//            uneArray[5] = ("55.0")          //Pos  5 - > BTCAVar.tMotor              Float
//            uneArray[6] = ("77.2")          //Pos  6 - > BTCAVar.rpm                 Float
//            uneArray[7] = ("6")             //Pos  7 - > BTCAVar.human               Int
//            uneArray[8] = ("3.3")           //Pos  8 - > BTCAVar.pasTorque           Float
//            uneArray[9] = ("3.7")           //Pos  9 - > BTCAVar.throttleIN          Float
//            uneArray[10] = ("0.99")         //Pos 10 - > BTCAVar.throttleOut        Float
//            uneArray[11] = ("3.444")        //Pos 11 - > BTCAVar.auxD               Float
//            uneArray[12] = ("23.73")        //Pos 12 - > BTCAVar.solarProductionAH  Float
//            uneArray[13] = ("2.1")          //Pos 13 - > BTCAVar.solarProductionA   Float
//            uneArray[14] = ("B")            //Pos 14 - > BTCAVar.flag               Int
//            return uneArray
//
//        default:
//            var uneArray = [String]()
//            uneArray[0] = ("2.8833")        //Pos  0 - > BTCAVar.consumptionAH       Float
//            uneArray[1] = ("48.14")         //Pos  1 - > BTCAVar.batteryVolt         Float
//            uneArray[2] = ("3.109")         //Pos  2 - > BTCAVar.consumptionA        Float
//            uneArray[3] = ("17.4")          //Pos  3 - > BTCAVar.speed               Float
//            uneArray[4] = ("124.5333")      //Pos  4 - > BTCAVar.distance            Float
//            uneArray[5] = ("55.0")          //Pos  5 - > BTCAVar.tMotor              Float
//            uneArray[6] = ("77.2")          //Pos  6 - > BTCAVar.rpm                 Float
//            uneArray[7] = ("6")             //Pos  7 - > BTCAVar.human               Int
//            uneArray[8] = ("3.3")           //Pos  8 - > BTCAVar.pasTorque           Float
//            uneArray[9] = ("3.7")           //Pos  9 - > BTCAVar.throttleIN          Float
//            uneArray[10] = ("0.99")         //Pos 10 - > BTCAVar.throttleOut        Float
//            uneArray[11] = ("3.444")        //Pos 11 - > BTCAVar.auxD               Float
//            uneArray[12] = ("0")            //Pos 12 - > BTCAVar.solarProduction  Float //TODO: pas la bonne car existe pas encore
//            uneArray[13] = ("B")            //Pos 14 - > BTCAVar.flag               Int
//
//            return uneArray
//        }
//    }
}





