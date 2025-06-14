
// MARK: - Generic GroupDisclosureView

struct GroupDisclosureView<SubGroup, Content: View>: View {
    let title: String
    let children: [String: SubGroup]
    let deleteTitle: String
    let deleteAction: () -> Void
    @Binding var refreshTrigger: Bool
    let contentBuilder: (String, SubGroup) -> Content

    @State private var isExpanded = false
    @State private var showDeleteAlert = false

    var body: some View {
        DisclosureGroup(
            isExpanded: $isExpanded,
            content: {
                ForEach(children.keys.sorted(), id: \.self) { key in
                    if let child = children[key] {
                        contentBuilder(key, child)
                            .padding(.leading)
                    }
                }
            },
            label: {
                HStack {
                    Text(title)
                    Spacer()
                    Button(role: .destructive) {
                        showDeleteAlert = true
                    } label: {
                        Image(systemName: "trash")
                    }
                    .alert("Delete all data for \(deleteTitle)?", isPresented: $showDeleteAlert) {
                        Button("Delete", role: .destructive) {
                            deleteAction()
                            refreshTrigger.toggle()
                        }
                        Button("Cancel", role: .cancel) { }
                    }
                }
            }
        )
    }
}
//
//  RideDataListView.swift — Fully Hierarchical View Implementation
//
//  Created by call151 on 2025-05-09. A LOT OF chatGPT
//

import SwiftData
import SwiftUI

struct RideDataListView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @State private var refreshTrigger = false
    @Binding var path: [Screen]
    
    @State private var startDate: Date = Calendar.current.date(byAdding: .day, value: -30, to: Date()) ?? Date()
    @State private var endDate: Date = Date()
    @State private var isLoading: Bool = false
    @State private var rideDataList: [RideDataModel] = []
    
    var body: some View {
        VStack {
            Spacer()
            if !isLoading && !rideDataList.isEmpty {
                RideDataHierarchyView(groupedData: groupRideData(rideDataList, trigger: refreshTrigger), refreshTrigger: $refreshTrigger)
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
            
            DateRangePickerView(startDate: $startDate, endDate: $endDate)
            
            Group {
                Button {
                    isLoading = true
                    Task {
                        await fetchRideData()
                    }
                } label: {
                    if isLoading {
                        Text("Loading")
                            .fontWeight(.medium)
                        ProgressView()
                            .progressViewStyle(.circular)
                            .frame(width: 100, height: 40)
                        
                    } else {
                        Text("Fetch Data")
                            .frame(width: 100, height: 40)
                            .fontWeight(.medium)
                        
                    }
                }
            }
            .padding(.bottom, 25)

        }
        .navigationTitle("RideData List")
    }
    
    func fetchRideData() async {
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


// MARK: - Grouping Structures


struct SecondGroup {
    var items: [String: [RideDataModel]]
}

struct MinuteGroup {
    var seconds: [String: SecondGroup]
}

struct HourGroup {
    var minutes: [String: MinuteGroup]
}

struct DayGroup {
    var hours: [String: HourGroup]
}

struct WeekGroup {
    var days: [String: DayGroup]
}

struct MonthGroup {
    var weeks: [String: WeekGroup]
}

struct TimeGroupedData {
    var months: [String: MonthGroup]
}

// MARK: - Grouping Logic

func groupRideData(_ data: [RideDataModel], trigger: Bool) -> TimeGroupedData {
    var grouped: [String: MonthGroup] = [:]
    let calendar = Calendar.current
//    var dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    for ride in data {
        let date = ride.date
        let monthKey = date.formatted(.dateTime.month(.wide))
        let day = calendar.component(.day, from: date)
        let weekStart = ((day - 1) / 7) * 7 + 1
        let weekEnd = min(weekStart + 6, calendar.range(of: .day, in: .month, for: date)?.count ?? 31)
        let weekKey = "\(weekStart)-\(weekEnd)"
        let dayKey = date.formatted(.dateTime.year().month().day())
//        let dayKey = dateFormatter.string(from: date)
        
        
        let hour = calendar.component(.hour, from: date)
        let hourKey = String(format: "%02d:00-%02d:00", hour, hour + 1)
        let minuteKey = date.formatted(.dateTime.hour().minute())
        let secondKey = date.formatted(.dateTime.hour().minute().second())
        
        // Insert ride into the hierarchy
        if grouped[monthKey] == nil {
            grouped[monthKey] = MonthGroup(weeks: [:])
        }
        if grouped[monthKey]!.weeks[weekKey] == nil {
            grouped[monthKey]!.weeks[weekKey] = WeekGroup(days: [:])
        }
        if grouped[monthKey]!.weeks[weekKey]!.days[dayKey] == nil {
            grouped[monthKey]!.weeks[weekKey]!.days[dayKey] = DayGroup(hours: [:])
        }
        if grouped[monthKey]!.weeks[weekKey]!.days[dayKey]!.hours[hourKey] == nil {
            grouped[monthKey]!.weeks[weekKey]!.days[dayKey]!.hours[hourKey] = HourGroup(minutes: [:])
        }
        
        if grouped[monthKey]!.weeks[weekKey]!.days[dayKey]!.hours[hourKey]!.minutes[minuteKey] == nil {
            grouped[monthKey]!.weeks[weekKey]!.days[dayKey]!.hours[hourKey]!.minutes[minuteKey] = MinuteGroup(seconds: [:])
        }
        
        if grouped[monthKey]!.weeks[weekKey]!.days[dayKey]!.hours[hourKey]!.minutes[minuteKey]!.seconds[secondKey] == nil {
            grouped[monthKey]!.weeks[weekKey]!.days[dayKey]!.hours[hourKey]!.minutes[minuteKey]!.seconds[secondKey] =  SecondGroup(items: [:])
        }
        
        grouped[monthKey]!.weeks[weekKey]!.days[dayKey]!.hours[hourKey]!.minutes[minuteKey]!.seconds[secondKey]!.items[secondKey, default: []].append(ride)
    }
    
    return TimeGroupedData(months: grouped)
}

// MARK: - Hierarchical Views

struct RideDataHierarchyView: View {
    let groupedData: TimeGroupedData
    @Binding var refreshTrigger: Bool
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        List {
            ForEach(groupedData.months.keys.sorted(), id: \.self) { month in
                if let monthGroup = groupedData.months[month] {
                    GroupDisclosureView(
                        title: month,
                        children: monthGroup.weeks,
                        deleteTitle: month,
                        deleteAction: {
                            let ridesToDelete = monthGroup.weeks.values
                                .flatMap { $0.days.values }
                                .flatMap { $0.hours.values }
                                .flatMap { $0.minutes.values }
                                .flatMap { $0.seconds.values }
                                .flatMap { $0.items.values }
                                .flatMap { $0 }
                            for ride in ridesToDelete {
                                modelContext.delete(ride)
                            }
                            try? modelContext.save()
                        },
                        refreshTrigger: $refreshTrigger
                    ) { week, weekGroup in
                        GroupDisclosureView(
                            title: week,
                            children: weekGroup.days,
                            deleteTitle: week,
                            deleteAction: {
                                let ridesToDelete = weekGroup.days.values
                                    .flatMap { $0.hours.values }
                                    .flatMap { $0.minutes.values }
                                    .flatMap { $0.seconds.values }
                                    .flatMap { $0.items.values }
                                    .flatMap { $0 }
                                for ride in ridesToDelete {
                                    modelContext.delete(ride)
                                }
                                try? modelContext.save()
                            },
                            refreshTrigger: $refreshTrigger
                        ) { day, dayGroup in
                            GroupDisclosureView(
                                title: day,
                                children: dayGroup.hours,
                                deleteTitle: day,
                                deleteAction: {
                                    let ridesToDelete = dayGroup.hours.values
                                        .flatMap { $0.minutes.values }
                                        .flatMap { $0.seconds.values }
                                        .flatMap { $0.items.values }
                                        .flatMap { $0 }
                                    for ride in ridesToDelete {
                                        modelContext.delete(ride)
                                    }
                                    try? modelContext.save()
                                },
                                refreshTrigger: $refreshTrigger
                            ) { hour, hourGroup in
                                GroupDisclosureView(
                                    title: hour,
                                    children: hourGroup.minutes,
                                    deleteTitle: hour,
                                    deleteAction: {
                                        let ridesToDelete = hourGroup.minutes.values
                                            .flatMap { $0.seconds.values }
                                            .flatMap { $0.items.values }
                                            .flatMap { $0 }
                                        for ride in ridesToDelete {
                                            modelContext.delete(ride)
                                        }
                                        try? modelContext.save()
                                    },
                                    refreshTrigger: $refreshTrigger
                                ) { minute, minuteGroup in
                                    GroupDisclosureView(
                                        title: minute,
                                        children: minuteGroup.seconds,
                                        deleteTitle: minute,
                                        deleteAction: {
                                            let ridesToDelete = minuteGroup.seconds.values
                                                .flatMap { $0.items.values }
                                                .flatMap { $0 }
                                            for ride in ridesToDelete {
                                                modelContext.delete(ride)
                                            }
                                            try? modelContext.save()
                                        },
                                        refreshTrigger: $refreshTrigger
                                    ) { second, secondGroup in
                                        SecondView(second: second, group: secondGroup, refreshTrigger: $refreshTrigger)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}





struct SecondView: View {
    @Environment(\.modelContext) private var modelContext
    let second: String
    let group: SecondGroup
    
    @State private var showDeleteAlert = false
    @Binding var refreshTrigger: Bool
    
    var body: some View {
        let rides = group.items[second] ?? []
        ForEach(rides, id: \.date) { ride in
            HStack {
                Text("\(ride.date.formatted(date: .omitted, time: .standard))")
                Text("Speed: \(ride.speed, specifier: "%.2f") km/h")
                Text("SolarProductionAh: \(ride.solarProductionAH, specifier: "%.2f") Ah")
                Text("consumptionAh: \(ride.consumptionAH, specifier: "%.2f") Ah")

                Spacer()
                Button(role: .destructive) {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                }
                .alert("Delete all data for \(second)?", isPresented: $showDeleteAlert) {
                    Button("Delete", role: .destructive) {
                        deleteSecond()
                    }
                    Button("Cancel", role: .cancel) { }
                }
                
                
            }
            .padding(.vertical, 2)
        }
    }
    
    private func deleteSecond() {
        let ridesToDelete = group.items.values
            .flatMap { $0 }
        
        for ride in ridesToDelete {
            modelContext.delete(ride)
        }
        
        try? modelContext.save()
        refreshTrigger.toggle()
    }
}


#Preview {
    RideDataListView(path: .constant([]))
    
}
