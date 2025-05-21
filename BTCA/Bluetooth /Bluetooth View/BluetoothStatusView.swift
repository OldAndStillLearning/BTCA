//
//  BluetoothStatusView2.swift
//  BTCA
//
//  Created by call151 on 2025-05-04.
//

import SwiftUI

struct BluetoothStatusView: View {
    @Environment(BluetoothManager.self) var bluetooth
    
    var body: some View {
        HStack {
            RadioWaveView()
            Text(bluetooth.bluetoothStatus)
            
            if bluetooth.bluetoothStatus == BluetoothConstant.Status_Connected {
                Text("\(bluetooth.dataReceivedNumberOfLinePercentGood, specifier: "%.1f") %")
            }
        }.font(.system(size: 20))
    }
}

#Preview {
    BluetoothStatusView()
        .environment(BluetoothManager(btcaViewModelWeak: BTCAViewModel()))
}
