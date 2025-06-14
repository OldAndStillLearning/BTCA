//
//  DatabaseManager.swift
//  BTCA
//
//  Created by call151 on 2025-03-10.
//
// from https://medium.com/@mrdanteausonio/how-to-access-swift-data-model-context-outside-of-view-hirearchy-using-a-data-service-8508f7a94683

import Foundation
import SwiftData

#if os(iOS) || os(iPadOS)  // TODO: NOT SURE
import UIKit

@Observable
class DatabaseManager {
    static let shared = DatabaseManager()
    
    var modelContext: ModelContext?
    private var buffer: [RideDataModel] = []
    private var bufferTimer: Timer?

    private init() {}

    func setModelContext(_ context: ModelContext) {
        self.modelContext = context
        startBufferFlushTimer()
    }

    func bufferRideData(_ newRideData: RideDataModel) {
        buffer.append(newRideData)
    }

    private func startBufferFlushTimer() {
        bufferTimer?.invalidate()
        bufferTimer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] _ in
            self?.flushBufferToDatabase()
        }
    }

    private func flushBufferToDatabase() {
        guard !buffer.isEmpty else { return }

        var taskID = UIBackgroundTaskIdentifier.invalid
        taskID = UIApplication.shared.beginBackgroundTask(withName: "FlushRideData") {
            UIApplication.shared.endBackgroundTask(taskID)
            taskID = .invalid
        }

        DispatchQueue.main.async { [weak self] in
            guard let self = self, let context = self.modelContext else {
                UIApplication.shared.endBackgroundTask(taskID)
                return
            }

            for ride in self.buffer {
                context.insert(ride)
            }

            do {
                try context.save()
                self.buffer.removeAll()
                print("✅ Flushed \(self.buffer.count) RideData objects to icloud")

            } catch {
                print("❌ Failed to flush RideData buffer:", error)
            }

            if taskID != .invalid {
                UIApplication.shared.endBackgroundTask(taskID)
            }
        }
    }
}



#else

import Foundation
import SwiftData

@Observable
class DatabaseManager {
    static let shared = DatabaseManager()
    
    private var modelContext: ModelContext?
    private var buffer: [RideDataModel] = []
    private var bufferTimer: Timer?
    
    private init() {}
    
    /// Call this as soon as you have a ModelContext (e.g. in your App’s init or SceneDelegate)
    func setModelContext(_ context: ModelContext) {
        self.modelContext = context
        startBufferFlushTimer()
    }
    
    /// Buffer new data points; they’ll get flushed every 10s
    func bufferRideData(_ newRideData: RideDataModel) {
        buffer.append(newRideData)
    }
    
    private func startBufferFlushTimer() {
        // Always schedule on the main run loop
        DispatchQueue.main.async {
            self.bufferTimer?.invalidate()
            self.bufferTimer = Timer.scheduledTimer(
                timeInterval: 10.0,
                target: self,
                selector: #selector(self.flushBufferToDatabase),
                userInfo: nil,
                repeats: true
            )
        }
    }
    
    @objc
    private func flushBufferToDatabase() {
        guard !buffer.isEmpty,
              let context = modelContext
        else { return }
        
        // Begin a “background” activity so macOS won’t suspend us mid-save
        let activity = ProcessInfo.processInfo.beginActivity(
            options: .background,
            reason: "FlushRideData"
        )
        
        // Insert everything into the model context
        for ride in buffer {
            context.insert(ride)
        }
        
        do {
            print("✅ Flushed \(buffer.count) RideData objects to iCloud ")
            try context.save()
            buffer.removeAll()

        } catch {
            print("❌ Failed to flush RideData buffer:", error)
        }
        
        // End the background activity
        ProcessInfo.processInfo.endActivity(activity)
    }    
}




#endif
