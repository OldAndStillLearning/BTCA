//
//  SetupEditView.swift
//  BTCA
//
//  Created by call151 on 2025-01-11.
//
import SwiftUI

struct SetupEditView: View {
    @Environment(BTCAViewModel.self) var viewModel
    @Binding var path: [Screen]
    @State private var showingFileInfo = false
    
    var body: some View {
        ScrollView {
            VStack {
                Text("")
                Text("")
                Section(header: Text("Battery").font(.title2 ) )  {
                    BatterySectionView()
                }
                Text("")
                Text("")
                Section(header: Text("Firmware").font(.title2 ) )  {
                    FirmwarePickerSectionView()
                }
                
                Text("")
                Text("")

                Section(header: Text("Unit").font(.title2 ) )  {
                    UnitPreferencesView()
                }
                
                #if os(iOS)
                Text("")
                Text("")

                Section(header: Text("Cellular").font(.title2 ) )  {
                    CellularUsageView()
                }
                #endif
                
                Text("")
                Text("")

                Section(header: Text("Location").font(.title2 ) )  {
                    LocationSectionView()
                }
                

                Text("")
                Text("")
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
                    FilesPrefView(path: $path)
                }
                
                
            }
            .padding(.horizontal)
//#if os(iOS)
#if os(iOS) || os(iPadOS) || os(visionOS)  || os(MacCatalyst)
            .navigationBarTitleDisplayMode(.inline)
#endif
        }
        .navigationTitle("Cycle Analyst Setup")
    }
}


#Preview {
    SetupEditView(path: .constant([]))
        .environment(BTCAViewModel())
}
