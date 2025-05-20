//
//  Screen.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-04-26.
//

import Foundation
import SwiftUI

// This Enum will cover ALL screens in your app
enum Screen: Hashable {

    // MARK: - Acceuil Screens
    case gridView
    case setupEditView
    case filesPrefView

    // MARK: - Display Preferences
    case editDisplayPreferenceView

    // subView of Display Preferences
    case editColorView
    case editPositionView
    case editPrecisionView
    case editTitleView
    case editUnitView
    
    // MARK: - Device Screens
    case deviceListView
    
    // MARK: - Chart/Analysis
    case chartListView
    case rideDataListView 
    case chartSolarProductionView
    case chartFlexibleView
    
    case infoView



}


