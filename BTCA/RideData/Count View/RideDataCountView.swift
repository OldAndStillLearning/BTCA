//
//  RideDataCountView.swift
//  BTCA
//
//  Created by call151 on 2025-03-10.
//
// do see this https://www.hackingwithswift.com/quick-start/swiftdata/how-to-count-results-without-loading-them

import SwiftData
import SwiftUI

struct RideDataCountView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var rideDataCount: Int = 0
    
    var body: some View {
        HStack {
            Button("Check iCloud") {
                loadRideDataCount()
            }
            .frame(maxWidth: .infinity)
            .buttonStyleGreen()
            
            Spacer(minLength: 5)

            Text("Count: \(rideDataCount)")
                .frame(maxWidth: .infinity)
                .buttonStyleBase()

        }
        .onAppear() {
            loadRideDataCount()
        }
    }
    
    
    func loadRideDataCount() {
        Task {
            let descriptor = FetchDescriptor<RideDataModel>()
            let count = (try? modelContext.fetchCount(descriptor)) ?? 0
            
            await MainActor.run {
                rideDataCount = count
            }
        }
    }
}



#Preview {
    RideDataCountView()
}
