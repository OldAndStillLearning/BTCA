//
//  BatteryCorrectionStepperView.swift
//  BTCA
//
//  Created by call151 on 2025-06-19.
//

import SwiftUI

struct BatteryCorrectionStepperView: View {
    @Environment(BTCAViewModel.self) var viewModel
    @Bindable var setup: Setup

    var body: some View {
        Stepper(" \(setup.batteryCapacityCorrectionAh, specifier: "%.1f")", value: $setup.batteryCapacityCorrectionAh, in: -100...100, step: 0.2)
            .foregroundColor(.green)
            .onChange(of: setup.batteryCapacityCorrectionAh) {
                setup.save()
                let (prodAh, consumpAh, capAh, _, battPercent)  = calculateVar()
                viewModel.batteryPercent = Float(battPercent)
                
                if viewModel.batteryPercent > 100 {
                    setup.batteryCapacityCorrectionAh = consumpAh - prodAh
                    setup.save()
                    let (_, _, _, _, battPercentT)  = calculateVar()
                    viewModel.batteryPercent = Float(battPercentT)
                }
               
                if viewModel.batteryPercent < 0 {
                    setup.batteryCapacityCorrectionAh = consumpAh - prodAh - capAh
                    setup.save()
                    let (_, _, _, _, battPercentT)  = calculateVar()
                    viewModel.batteryPercent = Float(battPercentT)
                }
                

            }
    }
    
    
    func calculateVar() -> (prodAh: Double, consumpAh: Double, capAh: Double, corrAh: Double, battPercent: Double) {
        
        let capAh = setup.batteryCapacityAh
        let consumpAh = Double(viewModel.rideDataPreparation?.rideDataPrevious.consumptionAhPrevious ?? 0)
        let prodAh = Double(viewModel.rideDataPreparation?.rideDataPrevious.solarProductionAH ?? 0)
        let corrAh = setup.batteryCapacityCorrectionAh
        let total = capAh - consumpAh + prodAh + corrAh
        let battPercent = total / capAh * 100
        
        return (prodAh, consumpAh, capAh, corrAh, battPercent)
    }
    
    
}

#Preview {
    let viewModel = BTCAViewModel()
    
    BatteryCorrectionStepperView(setup: viewModel.setup)
        .environment(viewModel)
}
