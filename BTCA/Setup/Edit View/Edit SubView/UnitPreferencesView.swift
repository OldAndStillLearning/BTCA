//
//  UnitPreferencesView.swift
//  BTCA
//
//  Created by call151 on 2025-05-19.
//

import SwiftUI


struct UnitPreferencesView: View {
    @Environment(BTCAViewModel.self) var viewModel
    
    var body: some View {
        @Bindable var setup = viewModel.setup
        
        VStack {
            Picker("", selection: $setup.distanceEnum) {
                ForEach(DistanceEnum.allCases) { unit in
                    Text(unit.rawValue.capitalized).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: setup.distanceEnum) {
                setup.save()
                metricOrStandardChanged()
            }
            
            
            Picker("", selection: $setup.speedEnum) {
                ForEach(SpeedEnum.allCases) { unit in
                    Text(unit.rawValue).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: setup.speedEnum) {
                setup.save()
                metricOrStandardChanged()
            }
            
            
            Picker("", selection: $setup.temperatureEnum) {
                ForEach(TemperatureEnum.allCases) { unit in
                    Text(unit.rawValue.capitalized).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: setup.temperatureEnum) {
                setup.save()
                metricOrStandardChanged()
            }
            
            Text("")
            Text("")
            Text("Location unit")
            
            Picker("", selection: $setup.iPhoneEnum) {
                ForEach(IPhoneEnum.allCases) { unit in
                    Text(unit.rawValue.capitalized).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: setup.iPhoneEnum) {
                setup.save()
                metricOrStandardChanged()
            }
            
            
            
        }
        .buttonStyle3Green()

    }
    
    func metricOrStandardChanged() {
        viewModel.metricOrStandardChanged()
    }
    
}

#Preview {
    UnitPreferencesView()
        .environment(BTCAViewModel())
}
