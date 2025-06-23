//
//  BatteryPresentView.swift
//  BTCA
//
//  Created by call151 on 2025-06-23.
//

import SwiftUI

struct BatteryPresentView: View {
//    @Binding var path: [Screen]
    @State private var showingBatteryInfo = false
    
    var body: some View {
    
        Section(header:
                    HStack {
            Spacer()
            Text("Battery")
                .font(.title2)
            Text(" ")
            Button {
                showingBatteryInfo = true
            } label: {
                Image(systemName: "info.circle")
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $showingBatteryInfo) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Battery Info")
                        .font(.title2)
                        .bold()
                    Text("Enter the total Ah ")
                    Text("For Correction")
                    Text("Battery level is a gross estimation based on previous level, consumption, production and a correction factor, all in Ah. You can adjust the current battery level with  correction.")
                    
                    // TODO: verify where
                    Spacer()
                    Button("Close") {
                        showingBatteryInfo = false
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding()
                .presentationDetents([.medium]) // half-sheet height
            }
            Spacer()
        }
        ) {
            BatterySectionView()
        }
        
        
    }
    
    
    
}

#Preview {
    let viewModel = BTCAViewModel()
    BatteryPresentView()
        .environment(viewModel)
}


