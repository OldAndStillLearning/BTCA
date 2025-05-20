//
//  FirmwarePickerSectionView.swift
//
//  Created by call151 on 2025-02-12.
//

import SwiftUI

struct FirmwarePickerSectionView: View {
    @Environment(BTCAViewModel.self) var viewModel
    
    init() {
#if os(iOS) || os(iPadOS) || os(visionOS)  || os(MacCatalyst)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
#endif
    }
    
    var body: some View {
        @Bindable var setup = viewModel.setup
        
        VStack() {
            Picker(selection: $setup.firmwareType, label: Text("") ) {
                ForEach(FirmwareType.allCases) { type in
                    Text(type.rawValue).tag(type as FirmwareType)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: setup.firmwareType) {
                setup.resetFirmwareSelection()
                viewModel.firmwareWasChanged()
                setup.save()
                viewModel.resetQoS()
            }
            
            Picker(selection: $setup.firmwareVersion, label: Text("") ) {
                ForEach(FirmwareVersion.availableFirmware(for: setup.firmwareType)) { firmware in
                    Text(firmware.rawValue.capitalized).tag(firmware as FirmwareVersion)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: setup.firmwareVersion) {
                setup.resetFirmwareSelection()
                viewModel.firmwareWasChanged()
                setup.save()
                viewModel.resetQoS()
            }
        }
        .buttonStyle3Green()
    }
}


#Preview {
    FirmwarePickerSectionView()
        .environment(BTCAViewModel())
}
