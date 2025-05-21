//
//  DateRangePickerView.swift
//  BTCA
//
//  Created by call151 on 2025-05-06.
//

import SwiftUI

struct DateRangePickerView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    private var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
        let max = Date()
        return min...max
    }
    
    private var validatedStartDate: Binding<Date> {
        Binding(
            get: { startDate },
            set: { newValue in
                startDate = newValue
                if startDate > endDate {
                    endDate = startDate
                }
            }
        )
    }
    
    private var validatedEndDate: Binding<Date> {
        Binding(
            get: { endDate },
            set: { newValue in
                endDate = newValue
                if endDate < startDate {
                    startDate = endDate
                }
            }
        )
    }
    
    var body: some View {
        Group {
            if horizontalSizeClass == .compact {
                VStack {
                    datePickers
                }
            } else {
                HStack(spacing: 16) {
                    datePickers
                }
            }
        }
        .padding()
    }
    
    private var datePickers: some View {
        Group {
            DatePicker("Start Date",
                       selection: validatedStartDate,
                       in: dateClosedRange,
                       displayedComponents: [.date, .hourAndMinute])
            
            DatePicker("End Date",
                       selection: validatedEndDate,
                       in: dateClosedRange,
                       displayedComponents: [.date, .hourAndMinute])
        }
    }
}



#Preview {
    @Previewable @State  var startDate: Date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
    @Previewable @State  var endDate: Date = Date()
    
    DateRangePickerView(startDate: $startDate, endDate: $endDate)
        .padding()
}
