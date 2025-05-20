//
//  EditPrecisionView.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-04-25.
//

import SwiftUI

struct EditPrecisionView: View {
    @Environment(BTCAViewModel.self) var viewModel2
    
    var body: some View {
        @Bindable var viewModel = viewModel2
        VStack {
            HStack{
                Text("\tVar Name")
                Spacer()
                Text("Unit ")
            }
            
            Form {
                ForEach(RideDataEnum.allCases) { btcaVar in
                    HStack {
                        TextField("", value: $viewModel.displayPreference.precision[btcaVar], formatter: numberFormatter)
                            .buttonStyleGreen()
                            .frame(width: 40)
                        Text("\(btcaVar.nameText)")
                            .frame(minWidth: 100, alignment: .leading)
                            .layoutPriority(1)
                        Spacer()
                        Text("\(viewModel.displayPreference.unit[btcaVar] ?? "????")")
                            .frame(minWidth: 40, alignment: .trailing)
                    }
                }
            }
            .onChange(of: viewModel.displayPreference.precision) {
                viewModel.displayPreference.save()
            }
            .navigationTitle("Edit Precision")
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}




#Preview {
    EditPrecisionView()
        .environment(BTCAViewModel())
}
