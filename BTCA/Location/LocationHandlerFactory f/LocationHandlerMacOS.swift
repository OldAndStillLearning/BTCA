//
//  LocationHandlerMacOS.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-04-20.
//

import Foundation
import CoreLocation
import os

final class LocationHandlerMacOS: NSObject, CLLocationManagerDelegate, LocationHandlerProtocol {
 
    private var locationManager = CLLocationManager()
   
    
    private var lastInfo = LocationInfo(
        timestamp: Date(),
        latitude: 0.0,
        longitude: 0.0,
        altitude: 0.0,
        speed: 0.0,
        direction: 0.0
    )

    






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
    }
    
    
    
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    
    func startLocationUpdates() {
        locationManager.startUpdatingLocation()
    }
    
    
    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
        
        lastInfo = LocationInfo(
            timestamp: Date(),
            latitude: 0.0,
            longitude: 0.0,
            altitude: 0.0,
            speed: 0.0,
            direction: 0.0
        )
    }
    

    func currentLocationInfo() -> LocationInfo {
        return lastInfo
    }
}
