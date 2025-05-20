//
//  TextModifier.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-03-29.
//

import Foundation
import SwiftUI



struct RoundedGrayBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.primary)
            .padding(5)
            .frame(maxWidth: .infinity, alignment: .leading)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.blue, lineWidth: 1)
            )
    }
}


struct ButtonStyleBase: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minHeight: 22)
            .padding(.horizontal, 22)
            .padding(.vertical, 6)
    }
}



struct ButtonStyleGreen: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyleBase()
            .foregroundColor(.green)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.green, lineWidth: 1) // green border
            )
    }
}


struct ButtonStyle3Green: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyleBase()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.green, lineWidth: 1) // green border
            )
    }
}


struct ButtonStyle3Blue: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyleBase()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.blue, lineWidth: 1)
            )
    }
}






extension View {
    func roundedGrayStyle() -> some View {
        self.modifier(RoundedGrayBackground())
    }
    
    func buttonStyleGreen() -> some View {
        self.modifier(ButtonStyleGreen())
    }
    
    func buttonStyle3Green() -> some View {
        self.modifier(ButtonStyle3Green())
    }

    
    func buttonStyle3Blue() -> some View {
        self.modifier(ButtonStyle3Blue())
    }
    

    func buttonStyleBase() -> some View {
        self.modifier(ButtonStyleBase())
    }
    
}




