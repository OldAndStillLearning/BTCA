//
//  DisplayPreferenceEditView.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-04-25.
//

import SwiftUI

struct EditDisplayPreferenceView: View {
    @Environment(BTCAViewModel.self) var viewModel
    @Binding var path: [Screen]
    
    var body: some View {
        VStack {
            Text("Edit Display Preference")
                .font(.largeTitle)
            HStack {
                Button("Edit Title") { path.append(.editTitleView)  } .frame(maxWidth: .infinity)
                    .buttonStyle3Blue()
                Button("Reset Title") { resetTitle() } .frame(maxWidth: .infinity)
                    .buttonStyle3Green()
            }
            .padding()
            
            HStack {
                Button("Edit Unit") {  path.append(.editUnitView) } .frame(maxWidth: .infinity)
                    .buttonStyle3Blue()
                Button("Reset Unit") { resetUnit()  } .frame(maxWidth: .infinity)
                    .buttonStyle3Green()
            }.padding()
            
            HStack {
                Button("Edit Precision") {  path.append(.editPrecisionView) } .frame(maxWidth: .infinity).buttonStyle3Blue()

                Button("Reset Precision") { resetPrecision() } .frame(maxWidth: .infinity)
                    .buttonStyle3Green()
            }.padding()
            
            HStack {
                Button("Edit Position") { path.append(.editPositionView)  }  .frame(maxWidth: .infinity).buttonStyle3Blue()
                Button("Reset Position") { resetPosition()  } .frame(maxWidth: .infinity).buttonStyle3Green()
            }.padding()
            
            HStack {
                Button("Edit Color") { path.append(.editColorView)}.frame(maxWidth: .infinity).buttonStyle3Blue()
                Button("Reset Color") {  resetColor() }  .frame(maxWidth: .infinity).buttonStyle3Green()
            }.padding()
        }
        .font(.system(size: 25))
        .navigationTitle("Display Preferences")
    }    
    func resetTitle() { viewModel.resetTitle() }
    func resetUnit() { viewModel.resetUnit() }
    func resetPrecision() { viewModel.resetPrecision() }
    func resetPosition() { viewModel.resetPosition() }
    func resetColor() { viewModel.resetColor() }
}



#Preview {
    EditDisplayPreferenceView(path: .constant([]))
        .environment(BTCAViewModel())
}
