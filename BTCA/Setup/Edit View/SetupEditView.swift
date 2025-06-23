//
//  SetupEditView.swift
//  BTCA
//
//  Created by call151 on 2025-01-11.
//
import SwiftUI

struct SetupEditView: View {
    @Environment(BTCAViewModel.self) var viewModel
    @Binding var path: [Screen]
    @State private var showingFileInfo = false
    
    var body: some View {
        ScrollView {
            VStack {
                SpacerT2()
                BatteryPresentView()
                
                SpacerT2()
                Section(header: Text("Firmware").font(.title2 ) )  {
                    FirmwarePickerSectionView()
                }
                
                
                SpacerT2()
                Section(header: Text("Unit").font(.title2 ) )  {
                    UnitPreferencesView()
                }
                
                SpacerT2()
                Section(header: Text("Location").font(.title2 ) )  {
                    LocationSectionView()
                }
                
                
                SpacerT2()
                FilePrefPresentView()
                

#if os(iOS)
                SpacerT2()
                Section(header: Text("Cellular").font(.title2 ) )  {
                    CellularUsageView()
                }
#endif
                
                SpacerT2()
                Section(header: Text("iCloud").font(.title2 ) )  {
                    RideDataCountView()
                        .padding(.vertical, 6)
                        .padding(.horizontal, 6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.green, lineWidth: 1) // green border
                        )
                }
                SpacerT2()
                SpacerT2()
            }
            .padding(.horizontal)
#if os(iOS) || os(iPadOS) || os(visionOS)  || os(MacCatalyst)
            .navigationBarTitleDisplayMode(.inline)
#endif
        }
        .navigationTitle("Cycle Analyst Setup")
    }
}


#Preview {
    SetupEditView(path: .constant([]))
        .environment(BTCAViewModel())
}
