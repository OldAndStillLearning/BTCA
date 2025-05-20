//
//  CellularUsageView.swift
//  BTCA
//
//  Created by call151 on 2025-05-18.
//

import SwiftUI

struct CellularUsageView: View {
    var body: some View {
        Button(action: {
#if os(iOS)
            openSettings()
            #endif
        }) {
            Text("Cellular usage to sync data ?")
        }
        .frame(maxWidth: .infinity)
        .buttonStyle3Blue()
        
    }
    
#if os(iOS)
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
#endif
}

#Preview {
    CellularUsageView()
}
