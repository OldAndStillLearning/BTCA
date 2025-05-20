//
//  ChartSolarProductionView.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-05-01.
// a lot's of help from chatGPT

import Charts
import SwiftData
import SwiftUI

struct ChartSolarProductionView: View {
    @Environment(BTCAViewModel.self) private var viewModel
    @Environment(\.modelContext) private var modelContext: ModelContext

    @Binding var path: [Screen]
    
    @State private var startDate: Date = Calendar.current.date(byAdding: .day, value: -30, to: Date()) ?? Date()
    @State private var endDate: Date = Date()
    @State private var isLoading = false
    @State private var zoomFactor: Double = 1
    @State private var chartDataByDay: [Date: [(Date, Double)]] = [:]

    private let dateCorrection : Double = 24*60*60        // in sec
    
    
    var body: some View {
        VStack() {
            Spacer()
            
            if !isLoading && !chartDataByDay.isEmpty {
                Group {
                    Chart {
                        ForEach(chartDataByDay.keys.sorted(), id: \.self) { day in
                            if let dataPoints = chartDataByDay[day] {
                                let dayLabel = day.formatted(.dateTime.day().month(.abbreviated).year())
                                ForEach(dataPoints, id: \.0) { point in
                                    LineMark(
                                        x: .value("Time", point.0),
                                        y: .value("Solar", point.1)
                                    )
                                    .interpolationMethod(.catmullRom)
                                    .foregroundStyle(by: .value("Day", dayLabel))
                                    
                                    AreaMark(
                                        x: .value("Time", point.0),
                                        y: .value("Solar", point.1)
                                    )
                                    .interpolationMethod(.catmullRom)
                                    .foregroundStyle(by: .value("Day", dayLabel))
                                    .opacity(0.15)
                                }
                            }
                        }
                    }
                    .chartXScale(domain: referenceDate...endOfReferenceDay)
                    .chartXVisibleDomain(length: dateCorrection - (3600*zoomFactor) )
                    .chartScrollableAxes(.horizontal)
                    .chartLegend(position: .bottom, alignment: .center)
                    .chartXAxis {
                        AxisMarks(values: .automatic(desiredCount: 24))
                    }
                    .chartYAxis {
                        AxisMarks(position: .leading)
                    }
                }
            }
            
            if !isLoading && chartDataByDay.isEmpty  {
                Text("No data available.")
                    .foregroundStyle(.secondary)
                    .padding()
            }
            
            if isLoading {
                ProgressView("Loading data…") .progressViewStyle(.circular)
            }

            Divider()
            
            DateRangePickerView(startDate: $startDate, endDate: $endDate)
    
            HStack {
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
                Text("")
                ChartSolarStepperView(zoomFactor: $zoomFactor )
            }
        }
        .padding()
    }

    
    private var referenceDate: Date {
        Calendar.current.startOfDay(for: Date(timeIntervalSince1970: 0))
        
    }
    
    private var endOfReferenceDay: Date {
        Calendar.current.date(byAdding: .hour, value: 24, to: referenceDate)!
    }
    
    private func loadData() async {
        defer { isLoading = false }
        do {
            let rawData = try await fetchSolarProductionData(startDate: startDate, endDate: endDate)
            let grouped = groupAndNormalize(rawData)
            await MainActor.run {
                self.chartDataByDay = grouped
            }
        } catch {
            print("Error fetching solar production data: \(error)")
            await MainActor.run {
                self.chartDataByDay = [:]
            }
        }
    }
    
    private func fetchSolarProductionData(startDate: Date, endDate: Date) async throws -> [(Date, Double)] {
        let fetchDescriptor = FetchDescriptor<RideDataModel>(
            predicate: #Predicate { ride in
                ride.date >= startDate && ride.date <= endDate
            },
            sortBy: [SortDescriptor(\RideDataModel.date)]
        )
        let results = try modelContext.fetch(fetchDescriptor)
        return results.map { ($0.date, Double($0.solarProductionWatts)) }
    }
    
    private func groupAndNormalize(_ data: [(Date, Double)]) -> [Date: [(Date, Double)]] {
        let calendar = Calendar.current
        let referenceDate = calendar.startOfDay(for: Date(timeIntervalSince1970: 0))
        
        let grouped = Dictionary(grouping: data) { (date, _) in
            calendar.startOfDay(for: date)
        }
        
        let filled: [Date: [(Date, Double)]] = grouped.mapValues { entries in
            var hourlyData: [(Date, Double)] = []
            
            for hour in 0..<24 {
                for minute in stride(from: 0, to: 60, by: 15) {
                    let match = entries.first { entry in
                        let comps = calendar.dateComponents([.hour, .minute], from: entry.0)
                        return comps.hour == hour && comps.minute == minute
                    }
                    
                    let normalizedDate = calendar.date(bySettingHour: hour, minute: minute, second: 0, of: referenceDate)!
                    let value = match?.1 ?? 0.0
                    hourlyData.append((normalizedDate, value))
                }
            }
            return hourlyData
        }
        return filled
    }
}
