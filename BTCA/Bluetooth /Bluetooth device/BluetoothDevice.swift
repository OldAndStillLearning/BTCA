//
//  BluetoothDevice.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-04-03.
//

import Foundation
import SwiftUI

@Observable
class BluetoothDevice: Identifiable, Codable, Equatable, Hashable {
    static func == (lhs: BluetoothDevice, rhs: BluetoothDevice) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: UUID
    var name: String
    var isAllowedToConnect: Bool = true
    
    
    init(id: UUID, name: String) {
        self.name = name
        self.id = id
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case id, name, isAllowedToConnect
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "BT device"
        self.isAllowedToConnect = try container.decodeIfPresent(Bool.self, forKey: .isAllowedToConnect) ?? true
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(isAllowedToConnect, forKey: .isAllowedToConnect)
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
