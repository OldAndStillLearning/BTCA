//
//  EditColorView.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-04-26.
//

import SwiftUI

struct EditColorView: View {
    @Environment(BTCAViewModel.self) var viewModel
    
    @State private var groupColors: [BTCAVarGroup: Color] = [:]
    @State private var othersGroupColor: Color = .black
    @State private var hasUserMadeChanges = false
    @State private var hasUserSetOthersGroupColor = false
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        VStack {
            Text("Edit Colors")
                .font(.largeTitle)
                .padding(.top)
            
            Form {
                // Sections for defined groups
                ForEach(BTCAVarGroup.allCases) { group in
                    Section(header: Text(group.rawValue)) {
                        groupColorPickerRow(
                            title: "Group Color",
                            color: Binding(
                                get: { groupColors[group] ?? getGroupColor(group) },
                                set: { newColor in
                                    groupColors[group] = newColor
                                    updateGroupColor(group: group, color: newColor)
                                    hasUserMadeChanges = true
                                }
                            )
                        )
                        
                        ForEach(group.variables) { variable in
                            colorPickerRow(for: variable)
                        }
                    }
                }
                
                // Section for Others
                Section(header: Text("Others")) {
                    groupColorPickerRow(
                        title: "Group Color",
                        color: $othersGroupColor,
                        action: { newColor in
                            hasUserSetOthersGroupColor = true
                            hasUserMadeChanges = true
                            updateOthersGroupColor(color: newColor)
                        }
                    )
                    
                    ForEach(otherVariables) { variable in
                        colorPickerRow(for: variable)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            for group in BTCAVarGroup.allCases {
                groupColors[group] = getGroupColor(group) 
            }
        }
        .onDisappear {
            if hasUserMadeChanges {
                viewModel.displayPreference.save()
            }
        }
    }
    
    // MARK: - Row Views
    
    func colorPickerRow(for variable: RideDataEnum) -> some View {
        HStack {
            Text(variable.nameText)
                .frame(width: 150, alignment: .leading)
            Spacer()
            ColorPicker("", selection: Binding(
                get: {
                    viewModel.displayPreference.color[variable]?.color ?? .black
                },
                set: { newColor in
                    viewModel.displayPreference.color[variable] = ColorCodable(from: newColor)
                    hasUserMadeChanges = true
                }
            ))
            .labelsHidden()
        }
    }
    
    func groupColorPickerRow(title: String, color: Binding<Color>, action: ((Color) -> Void)? = nil) -> some View {
        HStack {
            Label(title, systemImage: "paintpalette.fill")
                .font(.headline)
                .foregroundColor(idealTextColor(forBackground: color.wrappedValue))
            Spacer()
            ColorPicker("", selection: color)
                .labelsHidden()
                .frame(width: 50)
        }
        .padding(8)
        .background(color.wrappedValue)
        .cornerRadius(8)
        .onChange(of: color.wrappedValue) {
            action?(color.wrappedValue)
        }
    }
    
    // MARK: - Logic Helpers
    
    func getGroupColor(_ group: BTCAVarGroup) -> Color {
        if let firstVar = group.variables.first,
           let colorCodable = viewModel.displayPreference.color[firstVar] {
            return colorCodable.color
        }
        return .black
    }
    
    func updateGroupColor(group: BTCAVarGroup, color: Color) {
        for variable in group.variables {
            viewModel.displayPreference.color[variable] = ColorCodable(from: color)
        }
    }
    
    func updateOthersGroupColor(color: Color) {
        for variable in otherVariables {
            viewModel.displayPreference.color[variable] = ColorCodable(from: color)
        }
    }
    
    var otherVariables: [RideDataEnum] {
        let grouped = Set(BTCAVarGroup.allCases.flatMap { $0.variables })
        return RideDataEnum.allCases.filter { !grouped.contains($0) }
    }
    
    // MARK: - Adaptive Text Color
    
    func idealTextColor(forBackground background: Color) -> Color {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        
#if canImport(UIKit)
        UIColor(background).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
#elseif canImport(AppKit)
        NSColor(background).usingColorSpace(.deviceRGB)?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
#endif
        
        let brightness = (red * 299 + green * 587 + blue * 114) / 1000
        return brightness > 0.5 ? .black : .white
    }
}

#Preview {
    EditColorView()
        .environment(BTCAViewModel())
}


