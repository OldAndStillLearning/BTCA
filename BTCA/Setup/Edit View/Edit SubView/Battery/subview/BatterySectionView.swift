//
//  BatterySectionView.swift
//  BTCA
//
//  Created by call151 on 2025-04-25.
//

import SwiftUI

//struct BatteryCorrectionStepperView: View {
//    @Environment(BTCAViewModel.self) var viewModel
//    @Bindable var setup: Setup
//
//    var body: some View {
//        Stepper("", value: $setup.batteryCapacityCorrectionAh, in: -100...100, step: 0.1)
//            .onChange(of: setup.batteryCapacityCorrectionAh) {
//                let capAh = setup.batteryCapacityAh
//                let consumpAh = Double(viewModel.rideDataPreparation?.rideDataPrevious.consumptionAhPrevious ?? 0)
//                let proAh = Double(viewModel.rideDataPreparation?.rideDataPrevious.solarProductionAH ?? 0)
//                let corr = setup.batteryCapacityCorrectionAh
//                setup.batteryCapacityCorrectionAh = corr
//                let total = capAh - consumpAh + proAh + corr
//                let percent = total / viewModel.setup.batteryCapacityAh * 100
//                viewModel.batteryPercent = Float(percent)
//                setup.save()
//                viewModel.resetQoS()
//            }
//    }
//}

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
                            viewModel.resetQoS() // WHY ?? i dont remember
                        }
                }
            }
            
            
#if os(iOS) || os(iPadOS) || os(visionOS)  || os(MacCatalyst)
            HStack{
                Text("Bat: \(viewModel.batteryPercent, specifier: "%.1f") %" )
                    Text(" Corr:")
                    BatteryCorrectionStepperView(setup: setup)
            }
#else
            HStack{
                Text("Batt Level: \(viewModel.batteryPercent, specifier: "%.1f") %" )
                Spacer()
                Section("Correction Ah") {
                    BatteryCorrectionStepperView(setup: setup)
                }
            }
#endif
           
            
        }
        .buttonStyle3Green()
        .onAppear {
            calculatePercentLocally()
        }
        
    }
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    func calculatePercentLocally() {
        
        let capAh = viewModel.setup.batteryCapacityAh
        let consumpAh = Double(viewModel.rideDataPreparation?.rideDataPrevious.consumptionAhPrevious ?? 0)
        let proAh = Double(viewModel.rideDataPreparation?.rideDataPrevious.solarProductionAH ?? 0)
        let corr = viewModel.setup.batteryCapacityCorrectionAh
        viewModel.setup.batteryCapacityCorrectionAh = corr
        let total = capAh - consumpAh + proAh + corr
        let percent = total / viewModel.setup.batteryCapacityAh * 100
        viewModel.batteryPercent = Float(percent)
        
        
    }

    
}




#Preview {
    BatterySectionView()
        .environment(BTCAViewModel())
}
