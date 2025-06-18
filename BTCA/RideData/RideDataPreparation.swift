//
//  RideDataPreparation.swift
//  BTCA
//
//  Created by call151 on 2025-02-15.
//

import Foundation
import SwiftData
import CoreLocation

@Observable
class RideDataPreparation  {
    
    weak var btcaViewModelWeak: BTCAViewModel!
    var rideDataPrevious = RideDataPrevious()                  // data we received last time, that we need this time
    
    private var consumptionWattsHr = [Float]()
    private var dateArray = [Date]()
    private var distance  = [Float]()
    private var weNeedToCalculateNewBatteryCorrectionAtFull: Bool = false
    
    
    init(btcaViewModelWeak: BTCAViewModel) {
        self.btcaViewModelWeak = btcaViewModelWeak
    }



    func resetRideDataPrevious() {
        rideDataPrevious = RideDataPrevious()
    }

    

    
    //*******************************************************************************************************//
    //**                                                                                                   **//
    //** crunchANewLine                                                                                    **//
    //**                                                                                                   **//
    //**  All the Step to put received Data and Calculated Data into ride data before saving to SwiftData  **//
    //**                                                                                                   **//
    //**      1- get the order in which they arrive based on the firmware definition                       **//
    //**      2- Put the received data in that the model                                                   **//
    //**      3- Calculate the other data we want to save and display                                      **//
    //**                                                                                                   **//
    //**                                                                                                   **//
    //*******************************************************************************************************//
    func crunchANewLine(_ oneLineArray: [String])  -> RideDataModel  {
        
        let dataReceivedDefinition: [Int: RideDataEnum] = btcaViewModelWeak.setup.firmwareVersion.returnDataConfiguration()      // 1- definition
        let newArrayOfRideData = setArrayOfNewDataToProperBTCAVar(newData: oneLineArray, dataDefinition: dataReceivedDefinition) // 2-
        return   calculateOtherBTCAVar(rideData: newArrayOfRideData)     // 3-
    }
    
    
    //*******************************************************************************************************//
    //**
    //** setArrayOfNewDataToProperBTCAVar
    //**
    //**        -> 2- Put Received Value in the model and init all other value to default
    //**
    //**
    //**
    //*******************************************************************************************************//
    func setArrayOfNewDataToProperBTCAVar(newData:[String], dataDefinition: [Int: RideDataEnum]) -> RideDataModel {
        let newRideData: RideDataModel = RideDataModel()
        
        for (index, BTCAVarName) in dataDefinition {
            switch (BTCAVarName) {
            case RideDataEnum.auxD:              newRideData.auxD = Float(newData[index]) ?? 0
            case RideDataEnum.batteryVolt:       newRideData.batteryVolt = Float(newData[index]) ?? 0
            case RideDataEnum.acceleration:      newRideData.acceleration = Float(newData[index]) ?? 0
            case RideDataEnum.consumptionA:      newRideData.consumptionA = Float(newData[index]) ?? 0
            case RideDataEnum.consumptionAH:     newRideData.consumptionAH = Float(newData[index]) ?? 0
            case RideDataEnum.distance:          newRideData.distance = Float(newData[index]) ?? 0
            case RideDataEnum.flag:              newRideData.flag = String(newData[index])
            case RideDataEnum.human:             newRideData.human = Int16(newData[index]) ?? 0
            case RideDataEnum.pasTorque:         newRideData.pasTorque = Float(newData[index]) ?? 0
            case RideDataEnum.rpm:               newRideData.rpm = Float(newData[index]) ?? 0
            case RideDataEnum.solarProductionA:  newRideData.solarProductionA = Float(newData[index]) ?? 0
            case RideDataEnum.solarProductionAH: newRideData.solarProductionAH = Float(newData[index]) ?? 0
            case RideDataEnum.speed:             newRideData.speed = Float(newData[index]) ?? 0
            case RideDataEnum.throttleIN:        newRideData.throttleIN = Float(newData[index]) ?? 0
            case RideDataEnum.throttleOut:       newRideData.throttleOut = Float(newData[index]) ?? 0
            case RideDataEnum.tMotor:            newRideData.tMotor = Float(newData[index]) ?? 0
            default:                        break;  //  - populateRideData in switch i should not see a case default",
            }
        }
        
        newRideData.batteryAh = 0                   // init all other value, just in case
        newRideData.batteryLevelPercent = 0
        newRideData.batteryWattsHr = 0
        newRideData.consumptionWatts = 0
        newRideData.consumptionWattsHr = 0
        newRideData.date = Date()
        newRideData.gpsDateTime = Date() //TODO:  but later we will take the date and time at which the gps data were taken
        newRideData.gpsDirection = 0.0
        newRideData.gpsElevation = 0.0
        newRideData.gpsLatitude = 0.0
        newRideData.gpsLongitude = 0.0
        newRideData.gpsSpeed = 0.0
        newRideData.solarProductionWatts = 0.0
        newRideData.solarProductionWattsHr = 0.0
        newRideData.wattsHrByKmAverage = 0.0
        newRideData.wattsHrByKmInstant = 0.0
        
        return newRideData
    }
    
    
   
    
    
    
    
    //*******************************************************************************************************//
    //**
    //** calculateOtherBTCAVar
    //**
    //**        -> Calculated all others data Value
    //**
    //**
    //**
    //*******************************************************************************************************//
    func calculateOtherBTCAVar(rideData: RideDataModel) -> RideDataModel {
        
        
        //CALCUL - 20 - consumptionWatts
        rideData.consumptionWatts = rideData.batteryVolt * rideData.consumptionA

        //CALCUL - 29 - solarProductionWatts = Value-?? batteryVolt * Value-?? solarProductionA
        rideData.solarProductionWatts = rideData.batteryVolt * rideData.solarProductionA
   
        
        if weNeedToCalculateNewBatteryCorrectionAtFull {
            // ________________________________________________
            // battLevel = (prodAh - consAh + correctionAh) / battCapacityAh
            // but here  correction is unknown and battLevel is 100% (or 1)
            // 1 = (prodAh - consAh + correctionAh) / battCapacityAh
            // battCapacityAh  = prodAh - consAh + correctionAH
            // so   correctionAh = battCapacityAh - prodAh + consAh

            
            let correction = Float(btcaViewModelWeak.setup.batteryCapacityAh) - rideData.solarProductionAH + rideData.consumptionAH

            
            btcaViewModelWeak.setup.batteryCapacityCorrectionAh = Double(correction) // Ah
            btcaViewModelWeak.setup.save() // because we change the correction


              // ________________________________________________
               weNeedToCalculateNewBatteryCorrectionAtFull = false

            
            //            let rideData.batteryAh = rideData.solarProductionAH - rideData.consumptionAH + Float(setup.batteryCapacityCorrectionAh)
//            let temp1 = rideData.solarProductionAH - rideData.consumptionAH + Float(setup.batteryCapacityCorrectionAh)
//            let temp2 = (temp1 /    Float (setup.batteryCapacityAh) ) * 100
//
//            let alertText = ("new correction calculated \(setup.batteryCapacityCorrectionAh) \n new Batt level = \(temp2)")

        }
        
 
        //CALCUL - 17 - batteryAh = Value-?? solarProductionAH - Value-?? consumptionAH
        rideData.batteryAh = rideData.solarProductionAH - rideData.consumptionAH + Float(btcaViewModelWeak.setup.batteryCapacityCorrectionAh)
        
        //CALCUL - 18 - batteryLevelPercent
        rideData.batteryLevelPercent = (rideData.batteryAh   /   Float (btcaViewModelWeak.setup.batteryCapacityAh) ) * 100
        btcaViewModelWeak.batteryPercent = rideData.batteryLevelPercent
       
        
        
        
        
        
        
        //*******************************************************************************************************z//
        //**
        //** Just to make equation shorter to read
        //**
        //*******************************************************************************************************z//
        
        let  VNow   = rideData.batteryVolt
        
        // _________________________________________________________________________________________
        // Consommation Wh
        //**
//        let  cWhPrev = rideDataPrevious.consumptionWattsHrPrevious           // Just to make it shorter to read
//        let  caHPrev = rideDataPrevious.consumptionAhPrevious                // Just to make it shorter to read
//        let  caHNow  = rideData.consumptionAH                                // Just to make it shorter to read
//        
//        //CALCUL - 21 - consumptionWattsHr
//        rideData.consumptionWattsHr = cWhPrev + ((caHNow - caHPrev) * VNow)         //  Wh(now) = Wh(prev) + [Ah(now) - Ah(prev)] * V(now)
     
        rideData.consumptionWattsHr = rideDataPrevious.consumptionWattsHrPrevious + ((rideData.consumptionAH - rideDataPrevious.consumptionAhPrevious) * rideData.batteryVolt)
        
        
        // _________________________________________________________________________________________
        // Solar Production Wh
        //**
        let pWhPrev = rideDataPrevious.solarProductionWattsHrPrevious
        let paHPrev = rideDataPrevious.solarProductionAhPrevious
        let paHNow  = rideData.solarProductionAH
        
        
        
        
        // _________________________________________________________________________________________
        // Battery Wh
        //**
        let bWhPrev = rideDataPrevious.batteryWattsHrPrevious
        let baHPrev = rideDataPrevious.batteryAhPrevious
        let baHNow  = rideData.batteryAh
        
        
        //*******************************************************************************************************z//
        //**
        //** CALCULATION
        //**
        //*******************************************************************************************************z//
        
        
        

        //CALCUL - 21 - consumptionWattsHr
//        //TODO: remove this when you now it is ok - for average calcul
//        if caHNow < caHPrev {
//            print ("WARNING: caHNow < caHPrev")
//        }

   
        //CALCUL - 30 - solarProductionWattsHr
        rideData.solarProductionWattsHr = pWhPrev + ((paHNow - paHPrev) * VNow)     //  Wh(now) = Wh(prev) + [Ah(now) - Ah(prev)] * V(now)
        
        //CALCUL - 19 - batteryWattsHr
        rideData.batteryWattsHr = bWhPrev + ((baHNow - baHPrev) * VNow)             //  Wh(now) = Wh(prev) + [Ah(now) - Ah(prev)] * V(now)
        print("\n\n ********************************" )
        print(" rideData.batteryWattsHr = bWhPrev + ((baHNow - baHPrev) * VNow) ")
        print("bWhPrev \(bWhPrev), baHNow \(baHNow), baHPrev \(baHPrev), VNow \(VNow) = rideData.batteryWattsHr \(rideData.batteryWattsHr)")
        
        
        //CALCUL - 22 - date
        rideData.date = Date()
        
        
        
        
        
        
        
        
        
        
        
        

        

        
        
        
        
        

        

        
        
        
        
        // _________________________________________________________________________________________
        // Calculated consommation instant and average
        
        // if array full, first remove last before inserting a new value at index zero
        if distance.count == btcaViewModelWeak.setup.numberOdDataToCumulatedToCalculateAverageConsumption {
            distance.removeLast()
            consumptionWattsHr.removeLast()
            dateArray.removeLast()
        }
        
        // Add new current data to array
        dateArray.insert(rideData.date, at: 0)
        distance.insert(rideData.distance, at: 0)
        consumptionWattsHr.insert(rideData.consumptionWattsHr, at: 0)
        
        
        // TODO: Problem with calculation
        if distance.count == btcaViewModelWeak.setup.numberOdDataToCumulatedToCalculateAverageConsumption {
            
            //CALCUL - 31 - wattsHrByKmAverage
            // TODO: Verify if instead of first and last, maybe better to take Min and Max
            if let kmBegin = distance.last, let kmEnd = distance.first {
                let distance = kmEnd - kmBegin
                if let wattsHrBegin = consumptionWattsHr.last, let wattsHrEnd = consumptionWattsHr.first {
                    let energyUsed = wattsHrEnd - wattsHrBegin
                    if distance >= 0 && energyUsed > 0 {
                        rideData.wattsHrByKmAverage = energyUsed / distance
                    } else {
                        rideData.wattsHrByKmAverage = -1
                    }
                }
            }
            
            
            //CALCUL - 32 - wattsHrByKmInstant
            var index = btcaViewModelWeak.setup.numberOdDataToCumulatedToCalculateInstantConsumption - 1
            if index < 0 { index = 0}
            if  let kmEnd = distance.first {
                let kmBegin = distance[index]
                let distance = kmEnd - kmBegin
                
                if  let wattsHrEnd = consumptionWattsHr.first {
                    let wattsHrBegin = consumptionWattsHr[index]
                    let energyUsed = wattsHrEnd - wattsHrBegin
                    if distance >= 0 && energyUsed > 0 {
                        rideData.wattsHrByKmInstant = energyUsed / distance
                    } else {
                        rideData.wattsHrByKmInstant = -1
                    }
                }
            }
        }
        
        
        // _________________________________________________________________________________________
        // GPS
        if btcaViewModelWeak.setup.isLocationDesired == true {
            let location = btcaViewModelWeak.locationHandler.currentLocationInfo()
            
            rideData.gpsDateTime     = location.timestamp
            rideData.gpsDirection    = location.direction
            rideData.gpsElevation    = location.altitude
            rideData.gpsLatitude     = location.latitude
            rideData.gpsLongitude    = location.longitude
            
            
            rideData.gpsSpeed        = location.speed
        }
//        else {
//            let location = btcaViewModelWeak.locationHandler.currentLocationInfo()
//            
//            
//                        rideData.gpsDateTime     = location.timestamp
//            rideData.gpsDirection    = location.direction
//            rideData.gpsElevation    = location.altitude
//            rideData.gpsLatitude     = location.latitude
//            rideData.gpsLongitude    = location.longitude
//            rideData.gpsSpeed        = location.speed
//
//        }
        
        

        
        
        // _________________________________________________________________________________________
        //  all data are done so we can insert the value into coredata/swiftdata
        //        acceuilVMWeak.insertInSwiftData(rideData: rideData)
        //        print ("RideData \(rideData.batteryVolt) saved into Database ")
        // _________________________________________________________________________________________
        // Calculation Over, we can now save the calculated data into previous for next calculation
        rideDataPrevious.checkTimeInterval()
        
        rideDataPrevious.solarProductionWattsHrPrevious = rideData.solarProductionWattsHr
        rideDataPrevious.solarProductionAhPrevious = rideData.solarProductionAH
        
        rideDataPrevious.consumptionWattsHrPrevious = rideData.consumptionWattsHr
        rideDataPrevious.consumptionAhPrevious = rideData.consumptionAH
        
        rideDataPrevious.batteryWattsHrPrevious = rideData.batteryWattsHr
        rideDataPrevious.batteryAhPrevious = rideData.batteryAh
        
        rideDataPrevious.solarProductionAH = rideData.solarProductionAH
        rideDataPrevious.consumptionAH = rideData.consumptionAH
        rideDataPrevious.batteryLevelPercent = rideData.batteryLevelPercent

        return rideData
    }
    

    
    
    func batteryIsFullNowWithPrevious () {
        // ________________________________________________
        // battLevel = (prodAh - consAh + correctionAh) / battCapacityAh
        // but here  correction is unknown and battLevel is 100% (or 1)
        // 1 = (prodAh - consAh + correctionAh) / battCapacityAh
        // battCapacityAh  = prodAh - consAh + correctionAH
        // so   correctionAh = battCapacityAh - prodAh + consAh

        
        let correction = Float(btcaViewModelWeak.setup.batteryCapacityAh) - rideDataPrevious.solarProductionAH + rideDataPrevious.consumptionAH

        
        btcaViewModelWeak.setup.batteryCapacityCorrectionAh = Double(correction) // Ah
        btcaViewModelWeak.setup.save() // because we change the correction
        
    }

    
    
    func batteryIsFullNow() {
        // Use this var to force correction calculation in data loop
            weNeedToCalculateNewBatteryCorrectionAtFull = true
            
    }
    
    
}









