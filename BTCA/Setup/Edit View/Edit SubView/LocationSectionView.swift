//
//  LocationSectionView.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-02-13.
//

import SwiftUI

struct LocationSectionView: View {
    @Environment(BTCAViewModel.self) var viewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        @Bindable var setup = viewModel.setup
        
        if horizontalSizeClass == .compact {
            VStack {
                Toggle("Location Update", isOn: $setup.isLocationDesired)
                    .frame(maxWidth: .infinity)
                    .buttonStyle3Green()
                    .toggleStyle(.switch)
                    .onChange(of: setup.isLocationDesired) {
                        if setup.isLocationDesired {
                            viewModel.checkBeforeStartLocationUpdateGPS()
                        } else {
                            setup.isLocationInBackGroundDesired = false
                            viewModel.stopLocationUpdateGPS()
                        }
                        setup.save()
                    }
                
                Toggle("Location Background", isOn: $setup.isLocationInBackGroundDesired)
                    .disabled(!setup.isLocationDesired)
                    .frame(maxWidth: .infinity)
                    .buttonStyle3Green()
                    .toggleStyle(.switch)
                
            }
        } else {
            HStack(spacing: 16) {
                Toggle("Location Update", isOn: $setup.isLocationDesired)
                    .frame(maxWidth: .infinity)
                    .buttonStyle3Green()
                    .toggleStyle(.switch)
                    .onChange(of: setup.isLocationDesired) {
                        if setup.isLocationDesired {
                            viewModel.checkBeforeStartLocationUpdateGPS()
                        } else {
                            setup.isLocationInBackGroundDesired = false
                            viewModel.stopLocationUpdateGPS()
                        }
                        setup.save()
                    }
                
                Toggle("Location Background", isOn: $setup.isLocationInBackGroundDesired)
                    .disabled(!setup.isLocationDesired)
                    .frame(maxWidth: .infinity)
                    .buttonStyle3Green()
                    .toggleStyle(.switch)
            }
        }
        


            
            

        
    }
    
    // TODO: 102 - managed Bluetooth Backgound location
    //  not managed yet - on by default, not needed because
    // from https://developer.apple.com/documentation/corelocation/handling-location-updates-in-the-background
    // app already stay active in background because bluetooth connection receive data
    /// On some Apple devices, the operating system preserves battery life by suspending the execution of background apps. For example, on iOS, iPadOS, and watchOS, the system suspends the execution of most apps shortly after they move to the background. In this suspended state, apps don’t run and don’t receive location updates from the system. Instead, the system enqueues location updates and delivers them when the app runs again, either in the foreground or background. If your app needs updates in a more timely manner, you can ask the system to not suspend your app while location services are active.
    ///Consider carefully whether your app really needs background location updates. Most apps need location data only while someone actively uses the app. Consider background updates only when your app needs to receive those updates in real time, perhaps to:
    
}

#Preview {
    LocationSectionView()
        .environment(BTCAViewModel())
}
