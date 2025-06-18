//
//  FeedbackView.swift
//  BTCA
//
//  Created by call151 on 2025-06-17.
//

import SwiftUI

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

#Preview {
    FeedbackView()
}
