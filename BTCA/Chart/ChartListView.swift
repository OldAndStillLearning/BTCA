//
//  ChartListView.swift
//  BTCA
//
//  Created by call151 on 2025-05-04.
//

import SwiftUI

struct ChartListView: View {
    @Binding var path: [Screen]
    
    var body: some View {
            VStack {
                HStack(alignment: .center, spacing: 10) {
                    Text("Charts")
                        .font(.largeTitle)
                }.padding()
                
                Button("SolarProductionChartView") {
                    path.append(.chartSolarProductionView)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle3Blue()
                
                

                SolarChartInformation()
                

                

                Button("ChartFlexibleView") {
                    path.append(.chartFlexibleView)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle3Blue()
                
                FlexibleChartInformation()
                
            }.padding()
            .navigationTitle("Charts")
    }
    
}

#Preview {
    ChartListView(path: .constant([]))
}


struct SolarChartInformation: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("")
            Text("Chart solar production during daytime.")
            Text("Each day of the date range is a different series")
            Text("")
            Text("")
            Text("")
        }
    }
}

struct FlexibleChartInformation: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("")
            Text("Chart one parameter over a date range")
            Text("")
            Text("")
            Text("")
        }
    }
}
