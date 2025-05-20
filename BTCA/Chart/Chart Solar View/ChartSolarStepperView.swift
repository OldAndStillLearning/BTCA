//
//  ChartSolarStepperView.swift
//  BTCA
//
//  Created by call151 on 2025-05-08.
//

import SwiftUI

struct ChartSolarStepperView: View {
    @Binding var zoomFactor: Double

    func incrementStep() {
        zoomFactor += 1
        if zoomFactor >= 24 { zoomFactor = 23.99 }
    }
    
    func decrementStep() {
        zoomFactor -= 1
        if zoomFactor < 0 { zoomFactor = 1}
    }


    var body: some View {
        Stepper("Zoom Factor: \(zoomFactor, specifier: "%.1f") ",
                 onIncrement: incrementStep,
                 onDecrement: decrementStep)
        .padding(5)
    }
}




#Preview {
    @Previewable @State var zoomFactor: Double = 1
    ChartSolarStepperView(zoomFactor: $zoomFactor)
}


struct ChartSolarStepperView2: View {
    @Binding var zoomFactor: Double

    
    
    func incrementStep() {
        zoomFactor += 0.5
        if zoomFactor >= 24 { zoomFactor = 23.99 }
    }
    
    func decrementStep() {
        zoomFactor -= 0.5
        if zoomFactor < 0 { zoomFactor = 1}
    }


    var body: some View {
        Stepper("Zoom Factor: \(zoomFactor, specifier: "%.1f") ",
                 onIncrement: incrementStep,
                 onDecrement: decrementStep)
        .padding(5)
    }
}
