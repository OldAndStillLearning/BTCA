//
//  LocationHandlerFactory.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-04-20.
//

import Foundation

enum LocationHandlerFactory {
    static func makeHandler() -> LocationHandlerProtocol {
#if os(macOS)
        return LocationHandlerMacOS()
#else
        if #available(iOS 16.0, *) {
            return LocationHandlerIOS16plus()
        }
        else {
            return LocationHandleriOSOlder()   //TODO: maybe will never be use because on os requierement in app setting minimum Deployement too high for those
        }
#endif
    }
}
