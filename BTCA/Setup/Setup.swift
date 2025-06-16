//
//  Setup.swift
//  TestFirmware2
//
//  Created by call151 on 2025-01-12.
//

import Foundation

// TODO: if setup change (save func ) we need to reset Quality of service
@Observable
class Setup: Codable {
    var batteryVNominal: Double = 48.0
    var batteryCapacityAh: Double = 8.0
    var batteryCapacityCorrectionAh: Double  = 0.0
    var firmwareType: FirmwareType = .Solar             // TODO: just for my testing, put STANDARD because most people use that
    var firmwareVersion: FirmwareVersion  = .CA3_13v1S  // TODO: just for my testing, put STANDARD because most people use that
    var allowWriteCycleAnalystRawData = false
    var allowWriteAllCalculatedData = false
    var isLocationDesired: Bool = false
    var isLocationInBackGroundDesired: Bool = false
    
    var distanceEnum: DistanceEnum = .kilometers
    var speedEnum: SpeedEnum = .kph
    var temperatureEnum: TemperatureEnum = .celsius
    var iPhoneEnum: IPhoneEnum  = .metric
    

    
    let numberOdDataToCumulatedToCalculateAverageConsumption = BTCAConstant.NUMBER_OF_DATA_TO_CALCULATED_AVERAGE_CONSUMPTION
    let numberOdDataToCumulatedToCalculateInstantConsumption = BTCAConstant.NUMBER_OF_DATA_TO_CALCULATED_INSTANT_CONSUMPTION
    
    
    private enum CodingKeys: String, CodingKey {
        case batteryVNominal, batteryCapacityAh, batteryCapacityCorrectionAh,
             firmwareType, firmwareVersion, allowWriteCycleAnalystRawData, allowWriteAllCalculatedData, isLocationDesired, isLocationInBackGroundDesired,
             distanceEnum, speedEnum, temperatureEnum, iPhoneEnum
    }
    
    
    // MARK: - from chatGPT Thread-Safe Singleton Instance //TODO: Check ?
    static let shared: Setup = {
        return Setup.load()
    }()
    
    
    // MARK: - from chatGPT
    init() {
        self.batteryVNominal = 48.0
        self.batteryCapacityAh = 8.0
        self.batteryCapacityCorrectionAh = 0.0
        self.firmwareType = .Solar          // TODO: remet standard car most people use that .Standard, .CA3_13,
        self.firmwareVersion = .CA3_13v1S
        self.allowWriteCycleAnalystRawData = true
        self.allowWriteAllCalculatedData = true
        self.isLocationDesired = true
        self.isLocationInBackGroundDesired = true
        self.distanceEnum = .kilometers
        self.speedEnum = .kph
        self.temperatureEnum = .celsius
        self.iPhoneEnum = .metric
    }
        
    
    // MARK: - from chatGPT
    static func load() -> Setup {
        let url = getFileURL()
        guard let data = try? Data(contentsOf: url),
              let loadedSetup = try? JSONDecoder().decode(Setup.self, from: data) else {
            return Setup() // Return a default Setup instance if the file doesn't exist
        }
        return loadedSetup
    }
    
    
    // MARK: - Codable Conformance
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.batteryVNominal = try container.decodeIfPresent(Double.self, forKey: .batteryVNominal) ?? 48.0
        self.batteryCapacityAh = try container.decodeIfPresent(Double.self, forKey: .batteryCapacityAh) ?? 8.0
        self.batteryCapacityCorrectionAh = try container.decodeIfPresent(Double.self, forKey: .batteryCapacityCorrectionAh) ?? 0.0
        self.firmwareType = try container.decodeIfPresent(FirmwareType.self, forKey: .firmwareType) ?? .Standard
        self.firmwareVersion = try container.decodeIfPresent(FirmwareVersion.self, forKey: .firmwareVersion) ?? .CA3_13
        self.allowWriteCycleAnalystRawData = try container.decodeIfPresent(Bool.self, forKey: .allowWriteCycleAnalystRawData) ?? false
        self.allowWriteAllCalculatedData = try container.decodeIfPresent(Bool.self, forKey: .allowWriteAllCalculatedData) ?? false
        self.isLocationDesired = try container.decodeIfPresent(Bool.self, forKey: .isLocationDesired) ?? false
        self.isLocationInBackGroundDesired = try container.decodeIfPresent(Bool.self, forKey: .isLocationInBackGroundDesired) ?? false
        
        self.distanceEnum = try container.decodeIfPresent(DistanceEnum.self, forKey: .distanceEnum) ?? DistanceEnum.kilometers
        self.speedEnum = try container.decodeIfPresent(SpeedEnum.self, forKey: .speedEnum) ?? SpeedEnum.kph
        self.temperatureEnum = try container.decodeIfPresent(TemperatureEnum.self, forKey: .temperatureEnum) ?? TemperatureEnum.celsius
        self.iPhoneEnum = try container.decodeIfPresent(IPhoneEnum.self, forKey: .iPhoneEnum) ?? IPhoneEnum.metric

    }
        
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(batteryVNominal, forKey: .batteryVNominal)
        try container.encode(batteryCapacityAh, forKey: .batteryCapacityAh)
        try container.encode(batteryCapacityCorrectionAh, forKey: .batteryCapacityCorrectionAh)
        try container.encode(firmwareType, forKey: .firmwareType)
        try container.encode(firmwareVersion, forKey: .firmwareVersion)
        try container.encode(allowWriteCycleAnalystRawData, forKey: .allowWriteCycleAnalystRawData)
        try container.encode(allowWriteAllCalculatedData, forKey: .allowWriteAllCalculatedData)
        try container.encode(isLocationDesired, forKey: .isLocationDesired)
        try container.encode(isLocationInBackGroundDesired, forKey: .isLocationInBackGroundDesired)
        
        try container.encode(distanceEnum, forKey: .distanceEnum)
        try container.encode(speedEnum, forKey: .speedEnum)
        try container.encode(temperatureEnum, forKey: .temperatureEnum)
        try container.encode(iPhoneEnum, forKey: .iPhoneEnum)
    }
    
    
    // MARK: - Methods for battery validation and saving
    func validateBatteryVoltNominal() {
        if batteryVNominal < BTCAConstant.batteryMinimum {
            self.batteryVNominal = BTCAConstant.batteryMinimum
        } else if batteryVNominal > BTCAConstant.batteryMaximum {
            self.batteryVNominal = BTCAConstant.batteryMaximum
        }
        save()
    }
    
    
    func validateBatteryAhNominal() {
        if batteryCapacityAh < BTCAConstant.batteryMinimum {
            self.batteryCapacityAh = BTCAConstant.batteryMinimum
        } else if batteryCapacityAh > BTCAConstant.batteryMaximum {
            self.batteryCapacityAh = BTCAConstant.batteryMaximum
        }
        save()
    }
    
    
    func resetFirmwareSelection() {
        let availableFirmware = FirmwareVersion.availableFirmware(for: self.firmwareType)
        self.firmwareVersion = availableFirmware.last ?? .CA3_13
        save()
    }
    
    
    private static func getFileURL() -> URL {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Could not retrieve document directory")
        }
        return documentDirectory.appendingPathComponent(BTCAConstant.setupJSONFileName)
    }
    
    
    func save() {
        do {
            let data = try JSONEncoder().encode(self)
            try data.write(to: Setup.getFileURL())
            print("SETUP save")
        } catch {
            print("Failed to save: \(error.localizedDescription)")
        }
    }
    
}
