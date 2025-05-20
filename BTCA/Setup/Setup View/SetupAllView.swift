//
//  SetupAllView.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-02-14.
//

import SwiftUI


struct SetupAllView: View {
    @Environment(Setup.self) var setup
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        HStack(){
            if horizontalSizeClass == .compact {
                Text("\(setup.firmwareType)")
                Spacer()
                Text("\(setup.batteryVNominal, specifier: "%.1f") V")
            } else {
                Text("Setup:  \(setup.firmwareType.shortName())")
                Spacer()
                Text("\(setup.batteryVNominal, specifier: "%.1f") Volts")
            }
            Spacer()
            Text("\(setup.batteryCapacityAh, specifier: "%.1f") Ah")
            Image(systemName: "pencil")
                .foregroundColor(.blue)
            
        }.padding(.horizontal)
    }
}



#Preview {
    SetupAllView()
        .environment(Setup.shared)
}
