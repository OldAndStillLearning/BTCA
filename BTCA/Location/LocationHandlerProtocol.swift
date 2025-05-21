//
//  LocationHandlerProtocol.swift
//  BTCA
//
//  Created by call151 on 2025-04-20.
// chatGPT

import CoreLocation

protocol LocationHandlerProtocol {
    func startLocationUpdates()
    func stopLocationUpdates()
    func currentLocationInfo() -> LocationInfo
}
