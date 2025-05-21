//
//  DeviceDetailView.swift
//  BTCA
//
//  Created by call151 on 2025-04-12.
//

import SwiftUI

struct DeviceDetailView: View {
    @Environment(BTCAViewModel.self) var viewModel
    @Bindable var device: BluetoothDevice
    
    var body: some View {
        @Bindable var deviceManager = viewModel.bluetoothDeviceManager
        VStack {
            Form {
                Text("Bluetooth device")
                    .font(.title3)

                HStack {
                Text("Name: ")
                    TextField("Name", text: $device.name)
                }
                Text("ID: \(device.id.uuidString)")
                Toggle("Allow Connection", isOn: $device.isAllowedToConnect)
                
            }
            .navigationTitle("Device Details")
            .onDisappear() {
                deviceManager.saveDevices()
            }
            DeviceDetailInformation()
                .padding()
            Spacer()
        }

    }
}



#Preview {
    @Previewable @State var device: BluetoothDevice = BluetoothDevice(id: UUID(), name: "Bluefruit" )
    let viewModel = BTCAViewModel()
    let bluetoothDeviceManager = BluetoothDeviceManager()
    DeviceDetailView(device: device)
        .environment(viewModel)
}


//#Preview {
//    struct PreviewWrapper: View {
//        @State private var path: [Screen] = []
//
//        var body: some View {
//            let viewModel = BTCAViewModel()
//            let bluetoothDeviceManager = BluetoothDeviceManager()
//            
//            // Add devices individually to ensure observation
//            bluetoothDeviceManager.devices.append(
//                BluetoothDevice(id: UUID(), name: "Bluefruit")
//            )
//            bluetoothDeviceManager.devices.append(
//                BluetoothDevice(id: UUID(), name: "Adafruit")
//            )
//
//            viewModel.bluetoothDeviceManager = bluetoothDeviceManager
//
//            return DeviceListView(path: $path)
//                .environment(viewModel)
//        }
//    }
//
//    return PreviewWrapper()
//}


struct DeviceDetailInformation: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("If you have multiple bluetooth device, you can select which one are allow to connect to ")
            Text("")
        }
    }
}
