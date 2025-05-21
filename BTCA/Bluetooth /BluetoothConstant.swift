//
//  BluetoothConstant.swift
//  BTCA
//
//  Created by call151 on 2025-02-13.
//

import CoreBluetooth
import Foundation

struct BluetoothConstant {
    
    static let Status_Connected = "Connected"
    static let Status_Disconnected = "Disconnected"
    
    
    // Bluetooth  service and Characteristic
    //  UUIDKey.swift
    //  Basic Chat
    //
    //  Created by Trevor Beaton on 12/3/16.
    //  Copyright © 2016 Vanguard Logic LLC. All rights reserved.
    
    // current version in 2024 by Trevor Beaton
    // https://learn.adafruit.com/build-a-bluetooth-app-using-swift-5/code
    
    //  Modified to be inside a struct
    static let kBLEService_UUID            = "6e400001-b5a3-f393-e0a9-e50e24dcca9e"
    static let kBLE_Characteristic_uuid_Tx = "6e400002-b5a3-f393-e0a9-e50e24dcca9e"
    static let kBLE_Characteristic_uuid_Rx = "6e400003-b5a3-f393-e0a9-e50e24dcca9e"

    static let BLEService_UUID = CBUUID(string: BluetoothConstant.kBLEService_UUID)
    static let BLE_Characteristic_uuid_Tx = CBUUID(string: BluetoothConstant.kBLE_Characteristic_uuid_Tx)//(Property = Write without response)
    static let BLE_Characteristic_uuid_Rx = CBUUID(string: BluetoothConstant.kBLE_Characteristic_uuid_Rx)// (Property = Read/Notify)


}
