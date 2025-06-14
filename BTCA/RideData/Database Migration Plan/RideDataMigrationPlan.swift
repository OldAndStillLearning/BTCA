//
//  MyMigrationPlan.swift
//  BTCA
//
//  Created by call151 on 2025-06-12.
//

import Foundation
import SwiftData

enum RideDataMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [   RideDataSchemaV1_0.self,
            RideDataSchemaV1_1.self,
            RideDataSchemaV1_2.self,
            RideDataSchemaV2_0.self
        ]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1_0toV1_1, migrateV1_1toV1_2, migrateV1_2toV2_0]
    }
    
        static let migrateV1_0toV1_1 = MigrationStage.lightweight(
            fromVersion: RideDataSchemaV1_0.self,
            toVersion: RideDataSchemaV1_1.self
        )
    
    
    
//    static let migrateV1_0toV1_1 = MigrationStage.custom(
//        fromVersion: RideDataSchemaV1_0.self,
//        toVersion: RideDataSchemaV1_1.self,
//        willMigrate: { context in
//            print("1Franco in will Migrate")
//        },
//        didMigrate: {context in
//            print("1Franco in did Migrate")
//        }
//    )
    
    // from https://www.hackingwithswift.com/forums/swift/how-to-change-property-type-with-custom-migration/25608
    static let migrateV1_1toV1_2 = MigrationStage.custom(
        fromVersion: RideDataSchemaV1_1.self,
        toVersion: RideDataSchemaV1_2.self,
        willMigrate: nil,
        didMigrate: { context in
            var instances: [RideDataSchemaV1_2.RideDataModel] = []
                       // Fetch a list of all instances
                       do {
                           instances = try context.fetch(FetchDescriptor<RideDataSchemaV1_2.RideDataModel>())
                           print("2Franco in did Migrate")
                       } catch {
                           print("Error while fetching instances from persistent data model")
                       }

                       for instance in instances {
                           instance.tempFlagString = String(instance.flagToBeDeleted)
                           print("2Franco in did Migrate")
                       }
                       do {
                           try context.save() // Don't forget to save or SwiftData might crash your app!
                       } catch {
                           print("Saving context failed")
                       }
        }
    )
    
    
    static let migrateV1_2toV2_0 = MigrationStage.lightweight(
        fromVersion: RideDataSchemaV1_2.self,
        toVersion: RideDataSchemaV2_0.self
    )
    

    
}



//    static let migrateV1_0toV1_1 = MigrationStage.custom(
//        fromVersion: SchemaV1_0.self,
//        toVersion: SchemaV1_1.self,
//        willMigrate: nil,
//        didMigrate: nil
//    )
    
    



    
//    [
//        MigrationStage.stage(
//            fromVersion: SchemaV1_0.self,
//            toVersion: SchemaV1_1.self,
//            willMigrate: { _ in
//                // Optional: pre-migration logic
//            },
//            didMigrate: { context in
//                let fetch = FetchDescriptor<SchemaV1_1.RideDataModel>()
//                if let items = try? context.fetch(fetch) {
//                    for item in items {
//                        if let oldFlag = item.value(forKey: "flag") as? Int16 {
//                            item.flag = String(oldFlag)
//                        }
//
//                        if item.acceleration == 0.0 {
//                            item.acceleration = 0.0
//                        }
//                    }
//                }
//
//                try? context.save()
//            }
//        )
//    ]
    
    
//    static var stages: [MigrationStage] = [
//        .init(
//            fromVersion: SchemaV1_0.self,
//            toVersion: SchemaV1_1.self,
//            willMigrate: { _ in
//                // Optional: pre-migration actions
//            },
//            didMigrate: { context in
//                let fetch = FetchDescriptor<SchemaV1_1.RideDataModel>()
//                if let items = try? context.fetch(fetch) {
//                    for item in items {
//                        // Convert flag from Int16 (if bridged) to String
//                        if let oldFlag = item.value(forKey: "flag") as? Int16 {
//                            item.flag = String(oldFlag)
//                        }
//
//                        // Set default value for new field
//                        if item.acceleration == 0.0 {
//                            item.acceleration = 0.0
//                        }
//                    }
//                }
//
//                try? context.save()
//            }
//        )
//    ]


