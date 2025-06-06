//
//  BluetoothTitleView.swift
//  BTCA
//
//  Created by call151 on 2025-05-04.
//

import SwiftUI

struct BluetoothTitleView: View {
    @Environment(BTCAViewModel.self) var viewModel
    
    var body: some View {

            HStack() {
                Text("Bluetooth is ")
                Text(viewModel.isBluetoothOn ? "On" : "Off")
                    .foregroundColor(viewModel.isBluetoothOn ? .green : .red)
            }
            .font(.largeTitle)
    }
}


#Preview {
    BluetoothTitleView()
        .environment( BTCAViewModel() )

}
