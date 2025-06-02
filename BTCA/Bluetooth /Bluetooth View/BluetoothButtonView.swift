//
//  BluetoothButtonView.swift
//  BTCA
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
            .disabled( bluetooth.isScanning  || viewModel.isBluetoothConnected)
            .opacity( (bluetooth.isScanning  || viewModel.isBluetoothConnected ) ? 0.5 : 1  )
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
    let viewModel = BTCAViewModel()
    BluetoothButtonView()
//        .environment(BluetoothManager(btcaViewModelWeak: BTCAViewModel()))
        .environment(BluetoothManager(btcaViewModelWeak: viewModel ))
        .environment(viewModel)
    
    
 
}
