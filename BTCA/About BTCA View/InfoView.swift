//
//  infoView.swift
//  BTCA
//
//  Created by call151 on 2025-05-18.
//

import SwiftUI

struct InfoView: View {
    @Binding var path: [Screen]
    
    var body: some View {
        ScrollView {
            VStack {
                Text("About BTCA")
                    .font(.title)
                InformationView()
                    .padding()
                FeedbackView()
                    .padding()
            }
            .frame(maxWidth: .infinity)
        }
    }
}



#Preview {
    InfoView(path: .constant([]))
}
