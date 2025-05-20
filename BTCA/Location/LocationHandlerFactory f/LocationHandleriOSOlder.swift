//
//  LocationHandleriOSOlder.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-04-20.
//

import Foundation
import CoreLocation
import os

final class LocationHandleriOSOlder: NSObject, CLLocationManagerDelegate, LocationHandlerProtocol {
    
    private let logger = Logger(subsystem: "buzz.amalia.btca", category: "LocationHandleriOSOlder")
    private let locationManager = CLLocationManager()

    private var lastInfo = LocationInfo(
        timestamp: Date(),
        latitude: 0.0,
        longitude: 0.0,
        altitude: 0.0,
        speed: 0.0,
        direction: 0.0
    )

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestWhenInUseAuthorization()
    }

    func startLocationUpdates() {
        locationManager.startUpdatingLocation()
    }

    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.last else { return }

        lastInfo = LocationInfo(
            timestamp: loc.timestamp,
            latitude: loc.coordinate.latitude,
            longitude: loc.coordinate.longitude,
            altitude: loc.altitude,
            speed: loc.speed,
            direction: loc.course
        )

        logger.info("iOS <16 location: \(loc.coordinate.latitude), \(loc.coordinate.longitude)")
    }

    func currentLocationInfo() -> LocationInfo {
        return lastInfo
    }
}

