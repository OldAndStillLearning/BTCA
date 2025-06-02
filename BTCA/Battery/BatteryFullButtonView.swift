//
//  BatteryFullButtonView.swift
//  BTCA
//
//  Created by call151 on 2025-05-04.
//

import SwiftUI

struct BatteryFullButtonView2: View {
    @Environment(BTCAViewModel.self) var viewModel
    
    var body: some View {
        Button(action: {
            viewModel.batteryisFullNow()
        }) {
            Text(" Batt. is full now")
                .disabled(!viewModel.isBatteryFullButtonEnable)
                .opacity(viewModel.isBatteryFullButtonEnable ? 1.0 : 0.5)
        }
    }
}


struct BatteryFullButtonView3: View {
    @Environment(BTCAViewModel.self) var viewModel
    
    var body: some View {
        Text("\(viewModel.batteryPercent, specifier: "%.1f") %")
    }
}



#Preview {
    BatteryFullButtonView2()
        .environment(BTCAViewModel())
}
