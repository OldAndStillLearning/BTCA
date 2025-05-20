//
//  BTCAApp.swift
//  BTCA
//
//  Created by call151 on 2025-05-06.
//

import CoreBluetooth
import SwiftData
import SwiftUI

@main
struct BTCAApp: App {
#if os(iOS) || os(iPadOS) || os(visionOS)  || os(MacCatalyst)
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
#else
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
#endif
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: RideDataModel.self)
    }
}
