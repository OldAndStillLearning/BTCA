//
//  BTCAApp.swift
//  BTCA
//
//  Created by call151 on 2025-05-06.
// help from https://www.youtube.com/watch?v=RjvaPAW4xQ0

import CoreBluetooth
import SwiftData
import SwiftUI

@main
struct BTCAApp: App {
#if os(iOS) || os(iPadOS) || os(visionOS)  || os(MacCatalyst)
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
#else
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
#endif
    
    
//    typealias RideDataModel = RideDataSchemaV2_0.RideDataModel
    
    
//
    
//    let containerWithMigration: ModelContainer
    
//    let config = ModelConfiguration(migrationPlan: MyMigrationPlan.self)
//    let container = try ModelContainer(migrationPlan: MyMigrationPlan.self, configurations: config)
    
    let container: ModelContainer

    
//    let container = try ModelContainer(
//        for: RideDataModel.self,
//        schemas: RideDataMigrationPlan.schemas,
//        migrationStages: RideDataMigrationPlan.stages
//    )
    

    
//    init() {
//       do {
//           containerWithMigration = try ModelContainer(for: RideDataModel.self, migrationPlan: MyMigrationPlan.self)
//            print("ok for this")
//        } catch {
//            fatalError("Could not configure the container")
//        }
//
//    }
  
    
    init() {
        do {
            container = try ModelContainer(
                for: RideDataModel.self,
                migrationPlan: RideDataMigrationPlan.self
            )
        } catch {
            fatalError("Failed to initialize model container.")
        }
        
        print(URL.applicationSupportDirectory.path(percentEncoded: false))

    }
    
    
//    init() {
//        do {
////            let config = ModelConfiguration(for: RideDataModel.self)
//            let containerWithMigration = try ModelContainer(for: RideDataModel.self, configurations: RideDataMigrationPlan.self)
//            print("ModelContainer successfully configured with migration")
//        } catch {
//            fatalError("Could not configure the container: \(error)")
//        }
//    }
//    
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
//        .modelContainer(for: RideDataModel.self)
        .modelContainer(container)
    }
    
    
}







//    private var container: ModelContainer = {
//        let schema = Schema([RideDataModel.self])
//        let container = try! ModelContainer(
//            let config = ModelConfiguration(for:SchemaV1_1, automaticallyMigrate: true)
//
//
//                                                MyMigrationPlan.self)
//            return try! ModelContainer(for: MyMigrationPlan.self, configurations: config)
//        }()
//
//    let container = ModelContainer
//            for: schema,
//            migrationPlan: MyMigrationPlan.self,
//            configurations: modelConfiguration
//        )
//
//
//    private var container: ModelContainer = {
//        let config = ModelConfiguration(for: MyMigrationPlan.self)
//        return try! ModelContainer(for: MyMigrationPlan.self, configurations: config)
//    }()
//
//
//    let container = try ModelContainer(
//        for: schema,
//        migrationPlan: MyMigrationPlan.self,
//        configurations: modelConfiguration
//    )
