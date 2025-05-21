//
//  ChartDataExporter.swift
//  BTCA
//
//  Created by call151 on 2025-04-30.
//

import Foundation

struct ChartPoint {
    var date: Date
    var value: Double
}

class ChartDataExporter {
    static func export(data: [ChartPoint], variable: RideDataEnum, fichierManager: FichierManager) {
        guard !data.isEmpty else { return }

        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"

        // Title line
        let lineTitle = "Date\t\(variable.rawValue)"

        // Data lines
        let dataLines = data.map { point in
            "\(df.string(from: point.date))\t\(point.value)"
        }

        // Combine title + data
        let content = ([lineTitle] + dataLines).joined(separator: "\n")

        df.dateFormat = "yyyy-MM-dd HH-mm-ss"
            let dateString = df.string(from: Date())
        
        
        let filename = "\(dateString) - ChartData for \(variable.rawValue).tsv"
        fichierManager.save(text: content, to: filename)
    }
}
