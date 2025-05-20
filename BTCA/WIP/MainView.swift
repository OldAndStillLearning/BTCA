//
//  MainView.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-04-02.
//

import SwiftUI

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = BTCAViewModel()
    @State private var selectedDisplayStyle: CellStyle = CellStyle.loadFromUserDefaults()
    @State private var path: [Screen] = [] // Global path for ALL navigation
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack {
                    Text("BTCA")
                        .font(.system(size: 50)) // Base size
                    
                    Section {
                        VStack {
                            Button {
                                path.append(.setupEditView)
                            } label: { SetupAllView()  }
                                .buttonStyle3Blue()
                            
                            Divider()
                            
                            HStack {
                                Button("RideData") {
                                    path.append(.rideDataListView)
                                }.frame(maxWidth: .infinity)
                                    .buttonStyle3Blue()
                                
                                Button("deviceList") {
                                    path.append(.deviceListView)
                                }.frame(maxWidth: .infinity)
                                    .buttonStyle3Blue()
                            }
                            
                            HStack {
                                Button("Display Pref") {
                                    path.append(.editDisplayPreferenceView)
                                }.frame(maxWidth: .infinity)
                                    .buttonStyle3Blue()

                                Button("Chart") {
                                    path.append(.chartListView)
                                }.frame(maxWidth: .infinity)
                                    .buttonStyle3Blue()
                            }
                        }
                    }
                    
                    Group {
                        Text("")
                        Text("")
                        Text("")
                    }
                    
                    Section(header: BluetoothTitleView() ) {
                        HStack {
                            VStack {
                                BluetoothStatusView()
                                    .font(.system(size: 15))
                                BluetoothButtonView()   }  }  }
                    
                    Section(header: Text("Grid")) {
                        VStack {
                            HStack {
                                Button("Grid View") {
                                    path.append(.gridView)
                                }
                                .frame(maxWidth: .infinity)
                                .buttonStyle3Blue()
                                .disabled(!viewModel.buttonToGridIsEnable)
                                .opacity(viewModel.buttonToGridIsEnable ? 1.0 : 0.5)
                                
                                
                                Button("Reset Position", action: resetPosition)
                                    .frame(maxWidth: .infinity)
                                    .buttonStyleGreen()
                            }
                            Toggle("   Simulation Mode", isOn: $viewModel.simulationMode)
                                .frame(maxWidth: .infinity)

                                .toggleStyle(.switch)                                .buttonStyleGreen()
                                .disabled(viewModel.isBluetoothConnected)
                                
                            
                            HStack {
                                BatteryFullButtonView2()
                                    .frame(maxWidth: .infinity)
                                
                                    .buttonStyleGreen()
                                
                                BatteryFullButtonView3()
                                    .frame(maxWidth: .infinity)
                                    .buttonStyleBase()
                            }
                            .padding(.vertical, 6)
                            .padding(.horizontal, 6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.green, lineWidth: 1) // green border
                            )
         
                            
                            RideDataCountView()
                                .padding(.vertical, 6)
                                .padding(.horizontal, 6)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.green, lineWidth: 1) // green border
                                )
                        }
                    }

                    Text("")
                    Text("")
                    
                    Section(header: Text("INFO")) {
                                Button("App Information") {
                                    path.append(.infoView)
                                }
                                .frame(maxWidth: .infinity)
                                .buttonStyle3Blue()
                                .disabled(!viewModel.buttonToGridIsEnable)
                                .opacity(viewModel.buttonToGridIsEnable ? 1.0 : 0.5)
                    }

                    
                }
                .padding()
            }
            .acceuilNavigationDestination(
                path: $path,
                viewModel: viewModel,
                selectedDisplayStyle: selectedDisplayStyle
            )
        }
        .environment(viewModel)
        .environment(viewModel.setup)
        .environment(viewModel.bluetoothManager)
        .onAppear {
            DatabaseManager.shared.setModelContext(modelContext)
            viewModel.bluetoothManager?.checkBeforeScanning()
        }
        .onChange(of: viewModel.isSetupValidated) {  checkConditionsAndNavigate() } //TODO: we have more to check now
    }
    
    
    func resetPosition() {      // TODO: maybe remove becase 2 place in the app for that
        viewModel.resetPosition()
    }
    
    
    
    func checkConditionsAndNavigate() {
        if viewModel.isSetupValidated && viewModel.isAllowedToNavigateAutomatically {
            viewModel.isAllowedToNavigateAutomatically = false
            path.append(.gridView)
        }
    }
}



#Preview {
    let btcaViewModel = BTCAViewModel()
    MainView()
        .environment(BluetoothManager(btcaViewModelWeak: btcaViewModel))
        .environment(btcaViewModel)
        .environment(btcaViewModel.setup)
        .environment(CellulesContainer())
    
}
