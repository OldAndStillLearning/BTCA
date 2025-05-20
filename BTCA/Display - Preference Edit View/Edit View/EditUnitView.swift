//
//  EditUnitView.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-04-26.
//

import SwiftUI

struct EditUnitView: View {
    @Environment(BTCAViewModel.self) var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        VStack {
            HStack {
                Text("Variable Name")
                Spacer()
                Text("Unit")
            }
            .padding()
            List {
                ForEach(RideDataEnum.allCases) { variable in
                    HStack {
                        Text(variable.nameText)
                            .frame(width: 150, alignment: .leading)
                        Spacer()
                        TextField("Enter Unit", text: Binding(
                            get: {
                                viewModel.displayPreference.unit[variable, default: ""]
                            },
                            set: { newValue in
                                viewModel.displayPreference.unit[variable] = newValue
                            }
                        ))
                        .textFieldStyle(.roundedBorder)
                        .buttonStyleGreen()
                        
                    }
                }
            }
        }
        .navigationTitle("Edit Unit")
        .onDisappear {
            viewModel.displayPreference.save()
        }
    }
}

#Preview {
    EditUnitView()
        .environment(BTCAViewModel())
}
