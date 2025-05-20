//
//  BluetoothButtonView.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-04-03.
//

import SwiftUI

struct BluetoothButtonView: View {
    @Environment(BluetoothManager.self) var bluetooth
    @Environment(BTCAViewModel.self) var viewModel
    
    var body: some View {
        HStack {
            Button("Start Scan") {
                viewModel.startScanning()
            }
            .disabled(bluetooth.isScanning )
            .opacity(!bluetooth.isScanning  ? 1 : 0.5)
            .frame(maxWidth: .infinity)
            .buttonStyleGreen()
            
            Button("  Disconnect  ") {
                viewModel.DisconnectCurrentPeripheral()
            }
            .disabled(!viewModel.isBluetoothConnected)
            .opacity(viewModel.isBluetoothConnected ? 1 : 0.5)
            .frame(maxWidth: .infinity)
            .buttonStyleGreen()
        }
    }
}


#Preview {
    BluetoothButtonView()
        .environment(BluetoothManager(btcaViewModelWeak: BTCAViewModel()))
}
