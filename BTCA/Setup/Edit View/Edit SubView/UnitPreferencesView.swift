//
//  UnitPreferencesView.swift
//  BTCA
//
//  Created by call151 on 2025-05-19.
//

import SwiftUI


struct UnitPreferencesView: View {
    @Environment(BTCAViewModel.self) var viewModel
    
    init() {
#if os(iOS) || os(iPadOS) || os(visionOS)  || os(MacCatalyst)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.green], for: .normal)
#endif
    }
    
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
                metricOrImperialChanged()
            }
            
            
            Picker("", selection: $setup.speedEnum) {
                ForEach(SpeedEnum.allCases) { unit in
                    Text(unit.rawValue).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: setup.speedEnum) {
                setup.save()
                metricOrImperialChanged()
            }
            
            
            Picker("", selection: $setup.temperatureEnum) {
                ForEach(TemperatureEnum.allCases) { unit in
                    Text(unit.rawValue.capitalized).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: setup.temperatureEnum) {
                setup.save()
                metricOrImperialChanged()
            }
            
//            Text("")
//            Text("")
//            Text("Location unit")
//            
//            Picker("", selection: $setup.iPhoneEnum) {
//                ForEach(IPhoneEnum.allCases) { unit in
//                    Text(unit.rawValue.capitalized).tag(unit)
//                }
//            }
//            .pickerStyle(.segmented)
//            .onChange(of: setup.iPhoneEnum) {
//                setup.save()
//                metricOrImperialChanged()
//            }
            
            
            
        }
        .buttonStyleGreen()

    }
    
    func metricOrImperialChanged() {
        viewModel.metricOrImperialChanged()
    }
    
}

#Preview {
    UnitPreferencesView()
        .environment(BTCAViewModel())
}
