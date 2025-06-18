//
//  ChartMultipleDataView.swift
//  BTCA
//
//  Created by call151 on 2025-06-17.
//

import Charts
import SwiftData
import SwiftUI

struct NormalizedChartPoint: Identifiable {
    let id = UUID()
    let time: Date
    let variable: RideDataEnum
    let normalizedValue: Double
}

struct ChartMultipleDataView: View {
    @Environment(BTCAViewModel.self) private var viewModel
    @Environment(\.modelContext) private var modelContext: ModelContext
    @Binding var path: [Screen]
    
    @State private var startDate: Date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
    @State private var endDate: Date = Date()
    @State private var isLoading: Bool = false
    
    @State private var zoomFactor: Double = 0.0
    @State private var initiaLenghtForZoom : Double = 24*60*60        // in sec
    @State private var zoomMultiplicator: Double = 1
    
    @State private var rideDataList: [RideDataModel] = []
    @State private var groupedNormalizedData: [RideDataEnum: [NormalizedChartPoint]] = [:]
    @State private var visibleVars: [RideDataEnum: Bool] = RideDataEnum.allCases.reduce(into: [:]) { $0[$1] = false }
    @State private var selectedTime: Date? = nil
    
    let colorMap: [RideDataEnum: Color] = [
        
        .batteryAh: Color.yellow,
        .batteryLevelPercent: Color.yellow,
        .batteryVolt: Color.yellow,
        .batteryWattsHr: Color.yellow,
        
            .consumptionA: Color.red,
        .consumptionAH: Color.red,
        .consumptionWatts: Color.red,
        .consumptionWattsHr: Color.red,
        
            .solarProductionA: Color.green,
        .solarProductionAH: Color.green,
        .solarProductionWatts: Color.green,
        .solarProductionWattsHr: Color.green,
        
            .auxD: Color.brown,
        
            .acceleration: Color.cyan,
        .speed: Color.purple,
        .distance: Color.white,
        .pasTorque: Color.white,
        .rpm: Color.white,
        .throttleIN: Color.pink,
        .throttleOut: Color.pink,
        .tMotor: Color.orange,
        .wattsHrByKmAverage: Color.teal,
        .wattsHrByKmInstant: Color.teal,
        
            .gpsDirection: Color.blue,
        .gpsElevation: Color.blue,
        .gpsLatitude: Color.blue,
        .gpsLongitude: Color.blue,
        .gpsSpeed: Color.blue
        
    ]
    
    var body: some View {
        VStack {
            Spacer()
            
            if !isLoading && !rideDataList.isEmpty {
                Chart {
                    ForEach(RideDataEnum.allCases, id: \.self) { variable in
                        if visibleVars[variable] == true {
                            ForEach(groupedNormalizedData[variable] ?? []) { point in
                                LineMark(
                                    x: .value("Time", point.time),
                                    y: .value("Value", point.normalizedValue)
                                )
                                .foregroundStyle(colorMap[variable] ?? .gray)
                                .symbol(by: .value("Variable", variable.rawValue))
                            }
                        }
                    }
                }
                .chartXScale(domain: startDate...endDate)
                .chartXVisibleDomain(length: initiaLenghtForZoom - (zoomMultiplicator * zoomFactor))
                .chartScrollableAxes(.horizontal)
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .chartOverlay { proxy in
                    GeometryReader { geo in
                        Rectangle().fill(Color.clear).contentShape(Rectangle())
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { value in
                                        let location = value.location
                                        if let date: Date = proxy.value(atX: location.x) {
                                            selectedTime = date
                                        }
                                    }
                            )
                    }
                }
                .padding()
            }
            if !isLoading && rideDataList.isEmpty {
                Text("No data available.")
                    .foregroundStyle(.secondary)
                    .padding()
            }
            if isLoading {
                ProgressView("Loading data…") .progressViewStyle(.circular)
            }
            
            Divider()
            
            VariableSelectionView(visibleVars: $visibleVars, colorMap: colorMap)
            
            
            
            
            
            
            DateRangePickerView(startDate: $startDate, endDate: $endDate)
            
            Button {
                isLoading = true
                Task {
                    await loadData()
                }
            } label: {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .padding(.vertical, 4)
                } else {
                    Text("Fetch Data")
                        .fontWeight(.medium)
                }
            }
            SpacerT2()
        }
        
    }
    
    private func loadData() async {
        isLoading = true
        defer { isLoading = false }
        
        
        let descriptor = FetchDescriptor<RideDataModel>(
            predicate: #Predicate { $0.date >= startDate && $0.date <= endDate },
            sortBy: [SortDescriptor(\RideDataModel.date)]
        )
        do {
            rideDataList = try modelContext.fetch(descriptor)
            normalizeData()
        } catch {
            print("Fetch error: \(error)")
        }
        //        isLoading = false
    }
    
    private func normalizeData() {
        var grouped: [RideDataEnum: [NormalizedChartPoint]] = [:]
        for variable in RideDataEnum.allCases.filter({ $0.isNumericFloatOrDouble }) {
            let values = rideDataList.compactMap { model -> (Date, Double)? in
                guard let val = model.value(for: variable) else { return nil }
                return (model.date, val)
            }
            guard let min = values.map({ $0.1 }).min(),
                  let max = values.map({ $0.1 }).max(),
                  max != min else { continue }
            
            let normalized = values.map { (date, val) in
                NormalizedChartPoint(time: date, variable: variable, normalizedValue: (val - min) / (max - min) * 100.0)
            }
            grouped[variable] = normalized
        }
        groupedNormalizedData = grouped
    }
}

struct VariableSelectionView: View {
    @Binding var visibleVars: [RideDataEnum: Bool]
    let colorMap: [RideDataEnum: Color]
    
    var body: some View {
        
#if os(iOS) || os(iPadOS) || os(visionOS)
        ScrollView(.horizontal) {
            HStack {
                ForEach(RideDataEnum.allCases.filter { $0.isNumericFloatOrDouble }, id: \.self) { variable in
                    Toggle(variable.nameText, isOn: Binding(
                        get: { visibleVars[variable, default: true] },
                        set: { visibleVars[variable] = $0 }
                    ))
                    .toggleStyle(.button)
                    .foregroundColor(colorMap[variable])
                }
            }
            .padding(.horizontal)
        }
        
        
#endif
        
#if os(macOS)
        let columns = Array(repeating: GridItem(.flexible(minimum: 100)), count: 10)
        
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(RideDataEnum.allCases.filter { $0.isNumericFloatOrDouble }, id: \.self) { variable in
                Toggle(variable.nameText, isOn: Binding(
                    get: { visibleVars[variable, default: true] },
                    set: { visibleVars[variable] = $0 }
                ))
                .toggleStyle(.button)
                .foregroundColor(colorMap[variable])
            }
        }
        .padding()
        
        
#endif
        
    }
}


//ScrollView(.horizontal) {
//    HStack {
//        ForEach(RideDataEnum.allCases.filter { $0.isNumericFloatOrDouble }, id: \.self) { variable in
//            Toggle(variable.nameText, isOn: Binding(
//                get: { visibleVars[variable, default: true] },
//                set: { visibleVars[variable] = $0 }
//            ))
//            .toggleStyle(.button)
//            .foregroundColor(colorMap[variable])
//        }
//    }
//    .padding()
//}
