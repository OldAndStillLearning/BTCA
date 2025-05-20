//
//  FilesPrefView.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-04-06.
//

import SwiftUI

struct FilesPrefView: View {
    @Environment(BTCAViewModel.self) var viewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Binding var path: [Screen]
    
    var body: some View {
        @Bindable var setup = viewModel.setup
        
        VStack {
            
            if horizontalSizeClass == .compact {
                VStack {
                    Toggle("Raw Data from Cycle Analyst", isOn: $setup.allowWriteCycleAnalystRawData)
                        .frame(maxWidth: .infinity)
                        .buttonStyle3Green()
                        .toggleStyle(.switch)
                    Toggle("All Data calculated from this app", isOn: $setup.allowWriteAllCalculatedData)
                        .frame(maxWidth: .infinity)
                        .buttonStyle3Green()
                        .toggleStyle(.switch)
                }
                .onChange(of: setup.allowWriteCycleAnalystRawData) {
                    print("allowWriteCycleAnalystRawData changed \(setup.allowWriteCycleAnalystRawData)")
                    setup.save()
                }
                .onChange(of: setup.allowWriteAllCalculatedData) {
                    setup.save()
                }
            } else {
                
                HStack {
                    Toggle("Raw Data from Cycle Analyst", isOn: $setup.allowWriteCycleAnalystRawData)
                        .frame(maxWidth: .infinity)
                        .buttonStyle3Green()
                        .toggleStyle(.switch)
                    Toggle("All calculated Data", isOn: $setup.allowWriteAllCalculatedData)
                        .frame(maxWidth: .infinity)
                        .buttonStyle3Green()
                        .toggleStyle(.switch)
                }
                .onChange(of: setup.allowWriteCycleAnalystRawData) {
                    print("allowWriteCycleAnalystRawData changed \(setup.allowWriteCycleAnalystRawData)")
                    setup.save()
                }
                .onChange(of: setup.allowWriteAllCalculatedData) {
                    setup.save()
                }
            }
            
            

            
        }
    }
}

#Preview {
    FilesPrefView(path: .constant([]))
        .environment(BTCAViewModel())
}
