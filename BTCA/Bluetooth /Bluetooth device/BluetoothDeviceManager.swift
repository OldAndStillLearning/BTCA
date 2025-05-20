//
//  DeviceManager.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-04-12.
//

import Foundation
import SwiftUI

@Observable
class BluetoothDeviceManager {
    var devices: [BluetoothDevice] = []
    private let userDefaultsKey = "SavedBluetoothDevices"

    init() {
        loadDevices()
    }
    
    func addOrUpdateDevice(id: UUID, name: String) {
        if let index = devices.firstIndex(where: { $0.id == id }) {
            devices[index].name = name
        } else {
            let newDevice = BluetoothDevice(id: id, name: name)
            devices.append(newDevice)
        }
        saveDevices()
    }
    
    
    func deleteDevice(at offsets: IndexSet) {
        devices.remove(atOffsets: offsets)
        saveDevices()
    }

    
    func saveDevices() {
        do {
            let encodedData = try JSONEncoder().encode(devices)
            let userDefaults = UserDefaults.standard
            userDefaults.set(encodedData, forKey: userDefaultsKey)

        } catch {
            print("FAILED  to encode Devices to Data")
        }
    }
        
    
    private func loadDevices() {
        let userDefaults = UserDefaults.standard
        if let savedData = userDefaults.object(forKey: userDefaultsKey) as? Data {
            do{
                let tempDevices = try JSONDecoder().decode([BluetoothDevice].self, from: savedData)
                self.devices = tempDevices
            } catch {
                print("FAILED to convert Data to Devices")
            }
        }
    }
}

