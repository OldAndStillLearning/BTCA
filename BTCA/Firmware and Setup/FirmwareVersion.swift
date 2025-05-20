//
//  FirmwareVersion.swift
//  page Acceuil
//
//  Created by call151 on 2025-01-23.
//

import Foundation

enum FirmwareVersion: String, CaseIterable, Identifiable, Codable {
    
    var id: String { rawValue }
    
    // all firmware availalble so far for all type of Device
    case    CA3_11 = "CA3_11", CA3_12 = "CA3_12", CA3_13 = "CA3_13",                    // Standard
            CA3_14 = "CA3_14", CA3_15 = "CA3_15",                                       // Standard
            CA3_12a10 = "CA3_12a10",                                                    // Alpha
            CA3_11b3 = "CA3_11b3", CA3_12b1 = "CA3_12b1", SolarCA3_13b1 = "CA3_13b1",   // Beta
            CA3_13x1F = "CA3_13x1F", CA3_13x1G = "CA3_13x1G",                           // Experimental
            CA3_13v1S = "CA3_13v1S", CA3_1x19S = "CA3_1x19S"                            // Solar
    
    func associatedType() -> FirmwareType {
        switch self {
        case .CA3_15, .CA3_14, .CA3_13,.CA3_12, .CA3_11:
            return FirmwareType.Standard
            
        case FirmwareVersion.CA3_12a10:
            return FirmwareType.Alpha
            
        case FirmwareVersion.CA3_11b3, FirmwareVersion.CA3_12b1, FirmwareVersion.SolarCA3_13b1:
            return FirmwareType.Beta
            
        case FirmwareVersion.CA3_13x1F, FirmwareVersion.CA3_13x1G:
            return FirmwareType.Experimental
            
        case FirmwareVersion.CA3_13v1S, FirmwareVersion.CA3_1x19S:
            return FirmwareType.Solar
        }
    }
    
    // TODO: calculate number of data per version = not done yet  because i dont know the ouput 
    func numberOfDataPerFirmwareVersion () -> Int {
        switch self {
        case FirmwareVersion.CA3_13,FirmwareVersion.CA3_12, FirmwareVersion.CA3_11:
            return 14 // not tested
        case FirmwareVersion.CA3_12a10:
            return 14 // not tested
            
        case FirmwareVersion.CA3_11b3, FirmwareVersion.CA3_12b1, FirmwareVersion.SolarCA3_13b1:
            return 14 // not tested
            
        case FirmwareVersion.CA3_13x1F, FirmwareVersion.CA3_13x1G:
            return 14 // not tested
            
        case FirmwareVersion.CA3_13v1S, FirmwareVersion.CA3_1x19S:
            return 15           // not tested
        
        default:
                return 14
        }
    }
    
    // the Int is the index in dataRecieved and the coredata variable is where we should put this new data incore data
    
    func returnDataConfiguration() -> [Int: RideDataEnum] {
        switch self {
            
            // CASE SOLAR ->
        case FirmwareVersion.CA3_13v1S, FirmwareVersion.CA3_1x19S:
            var dataReceivedDefinition = [Int: RideDataEnum]()
            
            // Order we receveid - Exemple here first data is AH
            //            0    Ah    Consumption    x.xxxx    3
            dataReceivedDefinition[0] = RideDataEnum.consumptionAH
            
            //            1    Volts    V. Battery    xx.xx    2
            dataReceivedDefinition[1] = RideDataEnum.batteryVolt
            
            //            2    Amp    A Battery    xxx.xx    2
            dataReceivedDefinition[2] = RideDataEnum.consumptionA
            
            //            3    km/hr    Speed    xxx.x    1
            dataReceivedDefinition[3] = RideDataEnum.speed
            
            //            4    km    Distance    xxx.xx    2
            dataReceivedDefinition[4] = RideDataEnum.distance
            
            //            5    Celcius    T Motor    xxx.x    1
            dataReceivedDefinition[5] = RideDataEnum.tMotor
            
            //            6    RPM    RPM    xxx.x    1
            dataReceivedDefinition[6] = RideDataEnum.rpm
            
            //            7    Watts    Human Watts    xxxx    0
            dataReceivedDefinition[7] = RideDataEnum.human
            
            //            8    newtonMetre    PAS Torques    xxx.x    1
            dataReceivedDefinition[8] = RideDataEnum.pasTorque
            
            //            9    Volts    Throttle IN    x.xxx    3
            dataReceivedDefinition[9] = RideDataEnum.throttleIN
            
            //            10    Volts    Throttle Out    x.xxx    3
            dataReceivedDefinition[10] = RideDataEnum.throttleOut
            
            //            11    Percentage    AuxD    xx.x    1
            dataReceivedDefinition[11] = RideDataEnum.auxD
            
            //            12    AH    Solar Production     x.xxxx    4
            dataReceivedDefinition[12] = RideDataEnum.solarProductionAH
            
            //            13    Amp    Solar Current    xxx.xx    2
            dataReceivedDefinition[13] = RideDataEnum.solarProductionA
            
            //            14    Flags    Error    fffffff    0
            dataReceivedDefinition[14] = RideDataEnum.flag
            
            return dataReceivedDefinition
            
            
            // CASE STANDARD ->
        case FirmwareVersion.CA3_15, .CA3_14, .CA3_13, .CA3_12, .CA3_11 :
            var dataReceivedDefinition = [Int: RideDataEnum]()
            
            // Order we receveid - Exemple here first data is AH
            //            0    Ah    Consumption    x.xxxx    3
            dataReceivedDefinition[0] = RideDataEnum.consumptionAH
            
            //            1    Volts    V. Battery    xx.xx    2
            dataReceivedDefinition[1] = RideDataEnum.batteryVolt
            
            //            2    Amp    A Battery    xxx.xx    2
            dataReceivedDefinition[2] = RideDataEnum.consumptionA
            
            //            3    km/hr    Speed    xxx.x    1
            dataReceivedDefinition[3] = RideDataEnum.speed
            
            //            4    km    Distance    xxx.xx    2
            dataReceivedDefinition[4] = RideDataEnum.distance
            
            //            5    Celcius    T Motor    xxx.x    1
            dataReceivedDefinition[5] = RideDataEnum.tMotor
            
            //            6    RPM    RPM    xxx.x    1
            dataReceivedDefinition[6] = RideDataEnum.rpm
            
            //            7    Watts    Human Watts    xxxx    0
            dataReceivedDefinition[7] = RideDataEnum.human
            
            //            8    newtonMetre    PAS Torques    xxx.x    1
            dataReceivedDefinition[8] = RideDataEnum.pasTorque
            
            //            9    Volts    Throttle IN    x.xxx    3
            dataReceivedDefinition[9] = RideDataEnum.throttleIN
            
            //            10    Volts    Throttle Out    x.xxx    3
            dataReceivedDefinition[10] = RideDataEnum.throttleOut
            
            //            11    Percentage    AuxD    xx.x    1
            dataReceivedDefinition[11] = RideDataEnum.auxD
            
            //            12    AH    Solar Production     x.xxxx    4
            dataReceivedDefinition[12] = RideDataEnum.solarProductionA
            
            //            13    Flags    Error    fffffff    0
            dataReceivedDefinition[13] = RideDataEnum.flag
            
            return dataReceivedDefinition
            
            
            
        default:
           
            
            var dataReceivedDefinition = [Int: RideDataEnum]()
            
            // Order we receveid - Exemple here first data is AH
            //            0    Ah    Consumption    x.xxxx    3
            dataReceivedDefinition[0] = RideDataEnum.consumptionAH
            
            //            1    Volts    V. Battery    xx.xx    2
            dataReceivedDefinition[1] = RideDataEnum.batteryVolt
            
            //            2    Amp    A Battery    xxx.xx    2
            dataReceivedDefinition[2] = RideDataEnum.consumptionA
            
            //            3    km/hr    Speed    xxx.x    1
            dataReceivedDefinition[3] = RideDataEnum.speed
            
            //            4    km    Distance    xxx.xx    2
            dataReceivedDefinition[4] = RideDataEnum.distance
            
            //            5    Celcius    T Motor    xxx.x    1
            dataReceivedDefinition[5] = RideDataEnum.tMotor
            
            //            6    RPM    RPM    xxx.x    1
            dataReceivedDefinition[6] = RideDataEnum.rpm
            
            //            7    Watts    Human Watts    xxxx    0
            dataReceivedDefinition[7] = RideDataEnum.human
            
            //            8    newtonMetre    PAS Torques    xxx.x    1
            dataReceivedDefinition[8] = RideDataEnum.pasTorque
            
            //            9    Volts    Throttle IN    x.xxx    3
            dataReceivedDefinition[9] = RideDataEnum.throttleIN
            
            //            10    Volts    Throttle Out    x.xxx    3
            dataReceivedDefinition[10] = RideDataEnum.throttleOut
            
            //            11    Percentage    AuxD    xx.x    1
            dataReceivedDefinition[11] = RideDataEnum.auxD
            
            //            12    AH    Solar Production     x.xxxx    4
            dataReceivedDefinition[12] = RideDataEnum.solarProductionA
            
            //            13    Flags    Error    fffffff    0
            dataReceivedDefinition[13] = RideDataEnum.flag
            
            return dataReceivedDefinition
        }
    }
}



extension FirmwareVersion {
    static func availableFirmware(for type: FirmwareType) -> [FirmwareVersion] {
        allCases.filter { $0.associatedType() == type }
    }
}


