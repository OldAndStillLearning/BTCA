//
//  CellStyleBasicView.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-04-04.
//

import SwiftUI

struct CellStyleBasicView: View {
    let item: Cellule
    var body: some View {
        
        VStack {
            Text(item.title)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(item.valueToDisplay)
                .font(.system(size: 90)) // Base size
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
    }
}


#Preview {
    CellStyleBasicView(item: Cellule(id: 8, position: 3, valueToDisplay: "Test", color: Color.green, title: "T 'Motor", unit: "Celcius"))
}

