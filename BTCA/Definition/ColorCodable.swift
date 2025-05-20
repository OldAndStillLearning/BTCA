//
//  ColorCodable.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-03-13.
//
// part of the solution came from Google Gemini

import Foundation
import SwiftUI
//import UIKit            // even if UIColor is marked uikit in doc, it seems we dont need to import this ??

struct ColorCodable: Codable {
    var red: Double
    var green: Double
    var blue: Double
    var opacity: Double

#if os(iOS) || os(iPadOS) || os(visionOS)  || os(MacCatalyst)
    init(from color: Color) {
        let components = UIColor(color).cgColor.components!
        self.red = Double(components[0])
        self.green = Double(components[1])
        self.blue = Double(components[2])
        self.opacity = Double(components[3])
    }
#else
    init(from color: Color) {
        let components = NSColor(color).cgColor.components!
        self.red = Double(components[0])
        self.green = Double(components[1])
        self.blue = Double(components[2])
        self.opacity = Double(components[3])
    }
#endif


    var color: Color {
        return Color(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}



