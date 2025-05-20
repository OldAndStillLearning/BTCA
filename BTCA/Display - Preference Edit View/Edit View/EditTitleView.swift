//
//  EditTitleView.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-04-26.
//

import SwiftUI

struct EditTitleView: View {
    @Environment(BTCAViewModel.self) var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        VStack {
            HStack {
                Text("Variable Name")
                Spacer()
                Text("Title")
            }
            .padding()
            List {
                ForEach(RideDataEnum.allCases) { variable in
                    HStack {
                        Text(variable.nameText)
                            .frame(width: 150, alignment: .leading)
                        Spacer()
                        TextField("Enter Title", text: Binding(
                            get: {
                                viewModel.displayPreference.title[variable, default: ""]
                            },
                            set: { newValue in
                                viewModel.displayPreference.title[variable] = newValue
                            }
                        ))
                        .buttonStyleGreen()
                    }
                }
            }
        }
        .navigationTitle("Edit Titles")
        .onDisappear {
            viewModel.displayPreference.save()
        }
    }
}

#Preview {
    EditTitleView()
        .environment(BTCAViewModel())
    
}
