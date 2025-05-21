//
//  HowTOUse.swift
//  BTCA
//
//  Created by call151 on 2025-04-20.
//

import CoreLocation
import SwiftUI
import os


//let globalAuthDeniedError = "Please enable Location Services by going to Settings -> Privacy & Security"
//let authDeniedError = "Please authorize LiveUpdaterSampleApp to access Location Services"
//let authRestrictedError = "LiveUpdaterSampleApp can't access your location. Do you have Parental Controls enabled?"
//let accuracyLimitedError = "LiveUpdatesSample can't access your precise location, displaying your approximate location instead"
//


//class temporaire {
//    
//    let logger = Logger(subsystem: "com.apple.liveUpdatesSample", category: "AppDelegate")
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions
//                     launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
//        let locationsHandler = LocationsHandler.shared
//        
//        // If location updates were previously active, restart them after the background launch.
//        if locationsHandler.updatesStarted {
//            self.logger.info("Restart liveUpdates Session")
//            locationsHandler.startLocationUpdates()
//        }
//        // If a background activity session was previously active, reinstantiate it after the background launch.
//        if locationsHandler.backgroundUpdates {
//            self.logger.info("Reinstantiate background activity session")
//            locationsHandler.backgroundUpdates = true
//        }
//        return true
//    }
    
    
//
//    IN VIEW
//
//    BUTTON
//                Spacer()
//                Toggle("Location Updates", isOn: $locationsHandler.updatesStarted)
//                .frame(width: 200)
//                Toggle("BG Activity Session", isOn: $locationsHandler.backgroundUpdates)
//
//
//    IN LOCATION HANLDER
//
//    VAR

//    private var backgroundActivitySession: CLBackgroundActivitySession?
//    var lastUpdate: CLLocationUpdate? = nil
//    var lastLocation = CLLocation()
//    var count = 0
//    var isStationary = false
//    
//      @Published
//        var updatesStarted: Bool = UserDefaults.standard.bool(forKey: "liveUpdatesStarted") {
//            didSet {
//                updatesStarted ? self.startLocationUpdates() : self.stopLocationUpdates()
//                UserDefaults.standard.set(updatesStarted, forKey: "liveUpdatesStarted")
//            }
//        }
//        
//        @Published
//        var backgroundUpdates: Bool = UserDefaults.standard.bool(forKey: "BGActivitySessionStarted") {
//            didSet {
//                backgroundUpdates ? self.backgroundActivitySession = CLBackgroundActivitySession() : self.backgroundActivitySession?.invalidate()
//                UserDefaults.standard.set(backgroundUpdates, forKey: "BGActivitySessionStarted")
//            }
//        }
//
//
//
//        func startLocationUpdates() {
//            //if self.manager.authorizationStatus == .notDetermined {
//            //    self.manager.requestWhenInUseAuthorization()
//            //}
//            self.logger.info("Starting location updates")
//            Task {
//                do {
//                    let updates = CLLocationUpdate.liveUpdates()
//                    for try await update in updates {
//                        if !self.updatesStarted { break }  // End location updates by breaking out of the loop.
//                        self.lastUpdate = update
//                        if let loc = update.location {
//                            self.lastLocation = loc
//                            self.isStationary = update.stationary
//                            self.count += 1
//                            self.logger.info("Location \(self.count): \(self.lastLocation)")
//                        }
//                        if lastUpdate!.insufficientlyInUse {
////                            let notification = UNNotificationRequest(identifier: "com.example.mynotification", content: notificationContent, trigger: nil)
////                            try await notificationCenter.add(notification)
//                        }
//                    }
//                } catch {
//                    self.logger.error("Could not start location updates")
//                }
//                return
//            }
//        }
//        
//        func stopLocationUpdates() {
//            self.logger.info("Stopping location updates")
//            backgroundUpdates = false
//        }
//
//    
//}
//
//
//
//struct ErrorView: View {
//    @State var errorMessage: String
//    
//    var body: some View {
//        GroupBox {
//            HStack {
//                Image(systemName: "exclamationmark.triangle")
//                    .resizable()
//                    .frame(width: 50, height: 50)
//                Text(errorMessage)
//            }
//        }
//        .padding(20)
//        .cornerRadius(1)
//    }
//}



// HOW to USE
//
//final class MyViewModel {
//    private let locationHandler: LocationHandlerProtocol = LocationHandlerFactory.makeHandler()
//    
//    func startGPS() {
//        locationHandler.startLocationUpdates()
//    }
//    
//    func stopGPS() {
//        locationHandler.stopLocationUpdates()
//    }
//    
//    func readLocation() -> (CLLocation, CLLocationDirection, CLLocationSpeed, Date) {
//        locationHandler.currentLocationInfo()
//    }
//}
