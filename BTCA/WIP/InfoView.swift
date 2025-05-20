//
//  infoView.swift
//  BTCA
//
//  Created by call151 on 2025-05-18.
//

import SwiftUI

struct InfoView: View {
    @Binding var path: [Screen]
    
    var body: some View {
        ScrollView {
            VStack {
                Text("About BTCA")
                    .font(.title)
                Information()
                    .padding()
                FeedbackView()
                    .padding()
                
                
//                DisclosureGroup("App Description") {  Information() }
//                DisclosureGroup("Feedback") {  FeedbackView() }
 
            }
            .frame(maxWidth: .infinity)
            
        }
    }
}



// https://codewithchris.com/sending-email-in-swiftui/
struct FeedbackView: View {
    @Environment(\.openURL) private var openUrl
    
    var body: some View {
        Button("Email feedback, questions,\n bug or suggestions") {
            let email = "amalia.buzz@gmail.com"
            let subject = "App Feedback"
            let urlString = "mailto:\(email)?subject=\(subject)&body=Hello!"
            guard let url = URL(string: urlString) else { return }
            openUrl(url) { accepted in
                if !accepted {
                    // Handle the error, e.g., show an alert
                }
            }

        }
        .buttonStyle(.borderedProminent)
    }
}



struct Information: View {
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
            Text(" - Can't calculate Average ")
            Text(" - Need help ")

        }
    }
}


#Preview {
    InfoView(path: .constant([]))
}
