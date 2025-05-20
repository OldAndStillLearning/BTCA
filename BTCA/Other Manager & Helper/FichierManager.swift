//
//  FichierManager.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-04-05.
//

import Foundation

enum FileType: String {
    case cycleAnalystrawData  = "CaData"
    case allCalculatedData  = "AllData"
    case flexibleChart = "FlexChart"
}

class FichierManager {
    private let setup = Setup.shared
    
    private let numberOfLineToGetBeforeWritingToFile = 20
    private var numberofLineReceived = [FileType: Int]()
    private var textToWriteToFile = [FileType: String]()
    
    
    func newLineReceived(data: [String], fileType: FileType ) {
        let newLine = data.joined(separator: "\t") + "\n"
        textToWriteToFile[fileType, default: ""] += newLine
        numberofLineReceived[fileType, default: 0] += 1
        
        if numberofLineReceived[fileType, default: 0] >= numberOfLineToGetBeforeWritingToFile {
            if let textToWrite = textToWriteToFile[fileType] {
                AddToFile(manyLinesOfString: textToWrite, fileType: fileType)
                textToWriteToFile[fileType] = ""
                numberofLineReceived[fileType] = 0
            }
        }
    }
    
    
    
    func newLineOfAllDataReceived(rideData: RideDataModel, fileType: FileType ) {
        let newLine = RideDataModel.getARideDataInString(rideData: rideData) + "\n"
        
        textToWriteToFile[fileType, default: ""] += newLine
        numberofLineReceived[fileType, default: 0] += 1
        
        if numberofLineReceived[fileType, default: 0] >= numberOfLineToGetBeforeWritingToFile {
            if let textToWrite = textToWriteToFile[fileType] {
                AddToFile(manyLinesOfString: textToWrite, fileType: fileType)
                textToWriteToFile[fileType] = ""
                numberofLineReceived[fileType] = 0
            }
        }
    }
    
    
    func AddToFile(manyLinesOfString: String, fileType: FileType) {
        let fileManager = FileManager.default
        let fileName = fileName(for: fileType)
        let subdirectoryName = fileType.rawValue
        
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("❌ Failed to locate the documents directory.")
            return
        }
        
        let subdirectoryURL = documentsURL.appendingPathComponent(subdirectoryName)
        
        if !fileManager.fileExists(atPath: subdirectoryURL.path) {
            do {
                try fileManager.createDirectory(at: subdirectoryURL, withIntermediateDirectories: true, attributes: nil)
                print("📁 Subdirectory created at \(subdirectoryURL.path)")
            } catch {
                print("❌ Failed to create subdirectory: \(error)")
                return
            }
        }
        
        let fileURL = subdirectoryURL.appendingPathComponent(fileName)
        
        if !fileManager.fileExists(atPath: fileURL.path) {
            print("🆕 Creating file at \(fileURL.path)")
            fileManager.createFile(atPath: fileURL.path, contents: nil)
            let title = getFirstLineOfCSV(fileType: fileType)  + "\n"
            do {
                guard let myData = title.data(using: .utf8) else {
                    print("❌ Failed to convert string to data.")
                    return
                }
                
                let fileHandle = try FileHandle(forWritingTo: fileURL)
                defer { try? fileHandle.close() }
                
                try fileHandle.seekToEnd()
                try fileHandle.write(contentsOf: myData)
                print("✅ Successfully wrote to file.")
            } catch {
                print("❌ Error writing to file: \(error)")
            }
            
            
        } else {
            print("✅ File exists at \(fileURL.path)")
        }
        
        do {
            guard let myData = manyLinesOfString.data(using: .utf8) else {
                print("❌ Failed to convert string to data.")
                return
            }
            
            let fileHandle = try FileHandle(forWritingTo: fileURL)
            defer { try? fileHandle.close() }
            
            try fileHandle.seekToEnd()
            try fileHandle.write(contentsOf: myData)
            print("✅ Successfully wrote to file.")
        } catch {
            print("❌ Error writing to file: \(error)")
        }
    }
    
    
    

    
    
    private func getFirstLineOfCSV(fileType: FileType) -> String {
        
        switch fileType {
        case .cycleAnalystrawData:
            return RideDataEnum.titleForRawData(setup: setup)
            
        case .allCalculatedData:
            return RideDataEnum.titleForAllData()
            
        case .flexibleChart:
            return "TODO IF NEEDED"
        }
        
    }
    
    
    
    private func fileName(for fileType: FileType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = ("YYYY-MM-dd")
        
        let DateInString = dateFormatter.string(from: Date())
        return  DateInString + "-" + fileType.rawValue + ".csv"
    }
    
    
    func save(text: String, to filename: String) {                              // use only for ChartDataExporter
        let fileURL = getDocumentsDirectory().appendingPathComponent(filename)
        
        do {
            try text.write(to: fileURL, atomically: true, encoding: .utf8)
            print("✅ File saved at: \(fileURL.path)")
        } catch {
            print("❌ Error saving file: \(error)")
        }
    }

    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}


