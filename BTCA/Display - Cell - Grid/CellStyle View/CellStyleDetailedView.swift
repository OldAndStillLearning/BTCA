//
//  CellStyleDetailedView.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-03-27.
//

import SwiftUI

struct CellStyleDetailedView: View {
    let item: Cellule
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("ID: \(item.id)")
                Text("Position: \(item.position)")
            }
            Text("Title: \(item.title)")
            
            HStack {
                Text("Value: \(item.valueToDisplay)")
                Text(" ")
                Text("Unit: \(item.unit)")
            }
        }
        .font(.system(size: 22))
        .padding()
    }
}

#Preview {
    CellStyleDetailedView(item: Cellule())
}



