//
//  Information.swift
//  BTCA
//
//  Created by call151 on 2025-06-17.
//

import SwiftUI

struct InformationView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("This app ")
            Text(" - Get data from Cycle Analyst via bluetooth")
            Text(" - Does some calculations")
            Text(" - Store all data in database")
            Text(" - Display data in a reorderable grid view")
            Text(" - Sync data between devices via iCloud")
            Text(" - Work nativaly on iPhone, iPad and Mac")
            Text("")
            Text(" - Can get location data from iphone GPS")
            Text(" - Can do Chart for selected data or Solar")
            Text(" - Can export data to files while receiving")
            Text(" - Can export selected data")
            Text(" - Can delete selected data")
            Text("")
            Text(" - has many bugs ")
            Text(" - Can't calculate Average Consumption ")
            Text(" - Can't calculate Instant Consumption ")
            Text(" - Need help ")

        }
    }
}

#Preview {
    InformationView()
}
