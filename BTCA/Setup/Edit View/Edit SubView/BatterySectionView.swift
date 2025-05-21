//
//  BatterySectionView.swift
//  BTCA
//
//  Created by call151 on 2025-04-25.
//

import SwiftUI

struct BatterySectionView: View {
    @Environment(BTCAViewModel.self) var viewModel

    var body: some View {
        @Bindable var setup = viewModel.setup
  
        VStack() {
            HStack{
                Section("Volt") {
                    TextField("", value: $setup.batteryVNominal, formatter: numberFormatter)
                        .textFieldStyle(.roundedBorder)
                        .foregroundColor(.green)
#if os(iOS) || os(iPadOS) || os(visionOS)  || os(MacCatalyst)
                        .keyboardType(.decimalPad)
#endif
                        .onChange(of: setup.batteryVNominal) {
                            setup.validateBatteryVoltNominal()
                            setup.save()
                            viewModel.resetQoS()
                        }
                }
                
                Section("Ah") {
                    TextField("", value: $setup.batteryCapacityAh, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .foregroundColor(.green )
#if os(iOS) || os(iPadOS) || os(visionOS)  || os(MacCatalyst)
                        .keyboardType(.decimalPad)
#endif
                        .onChange(of: setup.batteryCapacityAh) {
                            setup.validateBatteryAhNominal()
                            setup.save()
                            viewModel.resetQoS()
                        }
                }
            }
        }
        .buttonStyle3Green()
    }
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}




#Preview {
    BatterySectionView()
        .environment(BTCAViewModel())
}
