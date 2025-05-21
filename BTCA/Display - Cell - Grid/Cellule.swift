//
//  Cellule.swift
//  BTCA
//
//  Created by call151 on 2025-03-19.
//

import Foundation
import SwiftUI

@Observable
class Cellule: Identifiable, Equatable {
    static func == (lhs: Cellule, rhs: Cellule) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: Int
    var position: Int
    var valueToDisplay: String
    var color: Color
    var title: String
    var unit: String
    
    init(id: Int, position: Int, valueToDisplay: String, color: Color, title: String, unit: String) {
        self.id = id
        self.position = position
        self.valueToDisplay = valueToDisplay
        self.color = color
        self.title = title
        self.unit = unit
    }
    
    init() {
        self.id = 26
        self.position = 1
        self.valueToDisplay = "25.67"
        self.color = .blue
        self.title = "speed"
        self.unit = "km/hr"
    }
    
}

