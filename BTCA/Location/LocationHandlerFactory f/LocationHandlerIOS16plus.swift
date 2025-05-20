//
//  LocationHandlerIOS16plus.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-04-20.
//
/* basd on code from  apple
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The app's main view.
*/

import Foundation
import CoreLocation
import os

#if os(iOS)
@available(iOS 16.0, *)


let globalAuthDeniedError = "Please enable Location Services by going to Settings -> Privacy & Security"
let authDeniedError = "Please authorize BTCA to access Location Services"
let authRestrictedError = "BTCA can't access your location. Do you have Parental Controls enabled?"
let accuracyLimitedError = "BTCA can't access your precise location, displaying your approximate location instead"


final class LocationHandlerIOS16plus: LocationHandlerProtocol {
 
    private let logger = Logger(subsystem: "buzz.amalia.BTCA", category: "LocationHandlerIOS16plus")
    
    
    private var backgroundSession: CLBackgroundActivitySession?
    private var task: Task<Void, Never>?
    
    private var backgroundActivitySession: CLBackgroundActivitySession?

    var lastLocation = CLLocation()
    
//    var isStationary = false
    
    private var lastInfo = LocationInfo(
        timestamp: Date(),
        latitude: 0.0,
        longitude: 0.0,
        altitude: 0.0,
        speed: 0.0,
        direction: 0.0
    )
    
    
    
    var updatesStarted: Bool = UserDefaults.standard.bool(forKey: "liveUpdatesStarted") {
        didSet {
            updatesStarted ? self.startLocationUpdates() : self.stopLocationUpdates()
            UserDefaults.standard.set(updatesStarted, forKey: "liveUpdatesStarted")
        }
    }
    
    
    var backgroundUpdates: Bool = UserDefaults.standard.bool(forKey: "BGActivitySessionStarted") {
        didSet {
            backgroundUpdates ? self.backgroundActivitySession = CLBackgroundActivitySession() : self.backgroundActivitySession?.invalidate()
            UserDefaults.standard.set(backgroundUpdates, forKey: "BGActivitySessionStarted")
        }
    }
    


    
    init() {
        backgroundSession = CLBackgroundActivitySession()
    }
    
    
    
    
    func startLocationUpdates() {
        let config = CLLocationUpdate.LiveConfiguration.otherNavigation
       
        task = Task.detached {
            do {
                let updates = CLLocationUpdate.liveUpdates(config)
                for try await update in updates {
//                    if !self.updatesStarted { break }
                    guard let loc = update.location else { continue }
                    await MainActor.run {
                        self.lastInfo = LocationInfo(
                            timestamp: loc.timestamp,
                            latitude: loc.coordinate.latitude,
                            longitude: loc.coordinate.longitude,
                            altitude: loc.altitude,
                            speed: loc.speed,
                            direction: loc.course
                        )
                    }
                }
            } catch {
                self.logger.error("Live update error: \(error.localizedDescription)")
            }
            return
        }
    }
    
    func stopLocationUpdates() {
//        updatesStarted = false
        task?.cancel()
        task = nil
        backgroundSession?.invalidate()
        backgroundSession = nil
    }
    
    
    func currentLocationInfo() -> LocationInfo {
        return lastInfo
    }
}

#endif
