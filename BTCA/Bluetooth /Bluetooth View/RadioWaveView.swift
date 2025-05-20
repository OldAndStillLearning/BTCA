//
//  RadioWaveView.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-02-17.
//

import SwiftUI

struct RadioWaveView: View {
    @Environment(BluetoothManager.self) var bluetoothManager
    
    @State private var visible = true
    
    var body: some View {
        
        if bluetoothManager.isScanning {
            HStack {
                Image(systemName: "dot.radiowaves.left.and.right")
                    .symbolEffect(.pulse)
                    .foregroundStyle(.tint)
                Text("Scanning")
                    .opacity(visible ? 1 : 0.2)
            }
            .onAppear(perform: pulsateText)
        } else {
            HStack {
                Image(systemName: "dot.radiowaves.left.and.right")
            }
        }
    }
    
    private func pulsateText() {
        withAnimation(Animation.easeInOut.repeatForever(autoreverses: true)) {
            visible.toggle()
        }
    }
}


#Preview {
    RadioWaveView()
        .environment(BluetoothManager(btcaViewModelWeak: BTCAViewModel()))
}
