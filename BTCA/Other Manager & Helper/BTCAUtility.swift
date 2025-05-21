//
//  BTCAUtility.swift
//  BTCA
//
//  Created by call151 on 2025-03-26.
//

import Foundation


struct BTCAUtility {
    
    static func dateToString(date: Date) -> String {
        return formatter.string(from: date)
    }
    
    private static let formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
    
    
    static func dateToTitle(date: Date) -> String {
        return formatter2.string(from: date)
    }
    
    
    private static let formatter2: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd EEEE"
        return dateFormatter
    }()
    
    
    static func dateForCATime(date: Date) -> String {
        return formatter3.string(from: date)
    }
    
    private static let formatter3: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS"
        return dateFormatter
    }()
    
    static func floatToString(value: Float, btcaVar: RideDataEnum, displayPreference: DisplayPreference) -> String{
        if let aPrecision = displayPreference.precision[btcaVar] {
            return doublePadding(Double(value), precision: aPrecision )
        } else {
            return doublePadding(Double(value), precision: 1 )
        }
    }

    
    
    static func doubleToString(value: Double, btcaVar: RideDataEnum, displayPreference: DisplayPreference ) -> String {
        if let aPrecision = displayPreference.precision[btcaVar] {
            return doublePadding(value, precision: aPrecision)
        } else {
            return doublePadding(value, precision: 1)
        }
    }
    
    
    static func doublePadding(_ value: Double, precision: Int) -> String{
        let multi = pow(10.0, Double(precision))
        let tempNumber = round(multi * value) / multi
        return padding(precision: precision, str: String(tempNumber))
    }
    
    
    static  func padding (precision: Int, str: String ) -> String{
        //TODO: todo rename var :-)
        
        if let lePointIndex = str.firstIndex(of: "."){
            let endEndex = str.endIndex
            let ecart = lePointIndex..<endEndex
            let aString  = str[ecart]
            
            let calcul = aString.count
            let precisionLocal = precision - calcul
            var stringAAjouter = ""
            
            guard precisionLocal >= 0 else { return str  }
            
            stringAAjouter = String.init(repeating: "0", count: precisionLocal+1)
            return str + stringAAjouter
        }else {
            let stringAAjouter = String.init(repeating: "0", count: precision)
            return str + "." + stringAAjouter
        }
    }
    
    
    static func addToName() -> String {
        let randomNumber = Int.random(in: 100...9999)
        return String(randomNumber)
    }
    
    
}
