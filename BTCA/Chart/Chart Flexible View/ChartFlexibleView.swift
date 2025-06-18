//
//  ChartFlexibleView.swift
//  BTCA
//
//  Created by call151 on 2025-05-08.
//
import Charts
import SwiftData
import SwiftUI

struct ChartFlexibleView: View {
    @Environment(BTCAViewModel.self) private var viewModel
    @Environment(\.modelContext) private var modelContext: ModelContext
    @Binding var path: [Screen]
    
    @State private var startDate: Date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
    @State private var endDate: Date = Date()
    @State private var isLoading: Bool = false
    
    @State private var zoomFactor: Double = 0.0
    @State private var initiaLenghtForZoom : Double = 24*60*60        // in sec
    @State private var zoomMultiplicator: Double = 1
    
    @State private var selectedVariable: RideDataEnum? = .consumptionWatts
    @State private var rideDataList: [RideDataModel] = []

    
    var body: some View {
        VStack {
            Spacer()
            
            if !isLoading && !rideDataList.isEmpty {
                Group {
                    if  let selectedVar = selectedVariable {
                        Chart(rideDataList) { rideData in
                            if let yValue = rideData.value(for: selectedVar) {
                                LineMark(
                                    x: .value("Time", rideData.date),
                                    y: .value(selectedVar.nameText, yValue)
                                )
                            }
                        }
                        .chartXScale(domain: startDate...endDate)
                        .chartXVisibleDomain(length: initiaLenghtForZoom - (zoomMultiplicator*zoomFactor) )
                        .chartScrollableAxes(.horizontal)
                        .chartYAxis {
                            AxisMarks()
                        }
                        .padding()
                    }
                }             
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
            
            
            Picker("Variable", selection: $selectedVariable) {
                Text("Choose...").tag(RideDataEnum?.none)
                ForEach(RideDataEnum.allCases.filter { $0.isNumericFloatOrDouble }, id: \.self) { variable in
                    Text(variable.nameText).tag(Optional(variable))
                }
            }
            .pickerStyle(.menu)
            
            DateRangePickerView(startDate: $startDate, endDate: $endDate)
            
            
            Button {
                isLoading = true
                Task {
                    await fetchRideData()
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
            
            
            Text("")
            //            ChartFlexibleChartSlider(zoomFactor: $zoomFactor )
            
            VStack {
                Slider(
                    value: $zoomFactor,
                    in: 0...29.9,
                    step: 0.5
                    //                onEditingChanged: { _ in calculatedInitialZoomLenght()  }
                ) {
                    Text("Zoom")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("30")
                }

            }       // Slider
            
            Group {
                Button("Save to File") {
                    let localData = rideDataList.compactMap { rideData -> ChartPoint? in
                        if let yValue = rideData.value(for: selectedVariable ?? .consumptionWatts ) {
                            return ChartPoint(date: rideData.date, value: yValue)
                        } else {
                            return nil
                        }
                    }
                    ChartDataExporter.export(
                        data: localData,
                        variable: selectedVariable ?? .consumptionWatts,
                        fichierManager: viewModel.fichierManager
                    )
                }
                .disabled(rideDataList.isEmpty)
                .frame(maxWidth: .infinity)
                .padding()
                .cornerRadius(8)
            }
            
        }
        .padding()
    }
    
    
    func fetchRideData() async {
        initiaLenghtForZoom = endDate.timeIntervalSince(startDate)
        zoomMultiplicator  = initiaLenghtForZoom / 30
        
        defer { isLoading = false }

        do {
            let request = FetchDescriptor<RideDataModel>(
                predicate: #Predicate { rideData in
                    rideData.date >= startDate && rideData.date <= endDate
                },
                sortBy: [SortDescriptor(\.date)]
            )
            let fetched = try modelContext.fetch(request)
            rideDataList = fetched
        } catch {
            print("Failed to fetch RideData: \(error)")
            rideDataList = []
        }
    }
    
    
    
}

//#Preview {
//    ChartFlexibleView()
//}
