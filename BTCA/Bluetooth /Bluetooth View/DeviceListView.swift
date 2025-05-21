//
//  DeviceListView.swift
//  BTCA
//
//  Created by call151 on 2025-04-12.
//

import SwiftUI

struct DeviceListView: View {
    @Environment(BTCAViewModel.self) var viewModel
    @Binding var path: [Screen]
    
    var body: some View {
        @Bindable var deviceManager = viewModel.bluetoothDeviceManager
        List {
            ForEach(deviceManager.devices) { device in
                NavigationLink(destination: DeviceDetailView(device:  device)) {
                    VStack{
                        
                        HStack {
                            Text(device.name)
                            Spacer()
                            Image(systemName: device.isAllowedToConnect ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(device.isAllowedToConnect ? .green : .red)
                        }
                        Text("\(device.id.uuidString)")
                    }
                }
            }.onDelete(perform: deviceManager.deleteDevice)
        }
        .navigationTitle("Bluetooth Devices")
#if os(iOS) || os(iPadOS) || os(visionOS)  || os(MacCatalyst)
        .toolbar {
            EditButton()
        }
#endif
    }
}



#Preview {
    struct PreviewWrapper: View {
        @State private var path: [Screen] = []

        var body: some View {
            let viewModel = BTCAViewModel()
            let bluetoothDeviceManager = BluetoothDeviceManager()
            
            // Add devices individually to ensure observation
            bluetoothDeviceManager.devices.append(
                BluetoothDevice(id: UUID(), name: "Bluefruit")
            )
            bluetoothDeviceManager.devices.append(
                BluetoothDevice(id: UUID(), name: "Adafruit")
            )

            viewModel.bluetoothDeviceManager = bluetoothDeviceManager

            return DeviceListView(path: $path)
                .environment(viewModel)
        }
    }

    return PreviewWrapper()
}





