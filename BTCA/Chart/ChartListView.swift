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
                
                Text("Chart")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Text("Solar")
                    .font(.title)
                SolarChartInformation()
                Button("SolarProductionChartView") {
                    path.append(.chartSolarProductionView)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle3Blue()

                SpacerT2()
                SpacerT2()
                
                                
                Text("Multiple")
                    .font(.title)
                ChartMultipleDataInformation()
                Button("ChartMultipleDataView") {
                    path.append(.chartMultipleDataView)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle3Blue()

                
                
                SpacerT2()
                SpacerT2()
                
                Text("One Data")
                    .font(.title)
                FlexibleChartInformation()
                Button("ChartFlexibleView") {
                    path.append(.chartFlexibleView)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle3Blue()
                
                
                
            }.padding()
            .navigationTitle("Charts")
        
        Spacer()
    }
    
}

#Preview {
    ChartListView(path: .constant([]))
}


struct SolarChartInformation: View {
    var body: some View {
        VStack(alignment: .leading){
//            Text("")
            Text("Chart solar production during daytime.")
            Text("Each day of the date range is a different series")
//            Text("")
//            Text("")
//            Text("")
        }
    }
}


struct ChartMultipleDataInformation: View {
    var body: some View {
        VStack(alignment: .leading){
//            Text("")
            Text("Chart multiple parameter on one chart")
        }
    }
}

struct FlexibleChartInformation: View {
    var body: some View {
        VStack(alignment: .leading){
//            Text("")
            Text("Chart one parameter over a date range")
        }
    }
}
