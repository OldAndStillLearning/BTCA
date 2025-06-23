//
//  FilePrefPresentView.swift
//  BTCA
//
//  Created by call151 on 2025-06-23.
//

import SwiftUI

struct FilePrefPresentView: View {
    
    @State private var showingFileInfo = false
    
    var body: some View {
        Section(header:
                    HStack {
            Spacer()
            Text("Files Saving")
                .font(.title2)
            Text(" ")
            Button {
                showingFileInfo = true
            } label: {
                Image(systemName: "info.circle")
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $showingFileInfo) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Files Saving Info")
                        .font(.title2)
                        .bold()
                    Text("On iOS and iPadOS use Files App -> on iPhone ")
                    Text("On macOS, use Finder -> Documents -> ?? -> Files")
                    // TODO: verify where
                    Spacer()
                    Button("Close") {
                        showingFileInfo = false
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding()
                .presentationDetents([.medium]) // half-sheet height
            }
            Spacer()
        }
        ) {
            FilesPrefView()
//            FilesPrefView(path: $path)
        }
    }
}




#Preview {
    FilePrefPresentView()
}
