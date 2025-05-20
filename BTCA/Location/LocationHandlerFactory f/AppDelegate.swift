/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The app delegate.
*/
// started from
//  Copyright © 2025 Apple. All rights reserved.
//  Article and code -> https://developer.apple.com/documentation/CoreLocation/adopting-live-updates-in-core-location
//  many evolution , helped by chatGPT


#if os(iOS) || os(iPadOS) || os(visionOS)  || os(MacCatalyst)
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return true
    }
}
#endif

#if os(macOS)
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {}
}
#endif
