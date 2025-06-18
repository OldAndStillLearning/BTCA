//
//  BTCAViewModel.swift
//  BTCA
//
//  Created by call151 on 2025-02-22.
//

import Combine
import Foundation
import SwiftData
import SwiftUI
import os

@Observable
class BTCAViewModel {
    var bluetoothManager: BluetoothManager?
    var simulationManager: SimulationManager?
    var rideDataPreparation: RideDataPreparation?
    
    let fichierManager = FichierManager()
    var bluetoothDeviceManager = BluetoothDeviceManager()
    var displayPreference = DisplayPreference.shared
    var setup = Setup.shared
    
    let limitFlagEnum = LimitFlagEnum.Preset1
    
    var demoData = [Cellule]()
    var cellulesContainer = CellulesContainer()
    
    var batteryPercent: Float = 0.0
    
    var navigateToGridAutomaticallyTimer: AnyCancellable?
    
    var isAllowedToNavigateAutomatically = true
    
    var navigateToGridAutomatically = false
    var buttonToGridIsEnable = true
    
    
    // use for Drag and Drop BUT after testing -> it is not needed but maybe should stay there
    //    var displayCanUpdate: Bool = true
    
    
    
    init () {
        self.bluetoothManager = BluetoothManager(btcaViewModelWeak: self)
        self.simulationManager = SimulationManager(btcaViewModelWeak: self)
        self.rideDataPreparation = RideDataPreparation(btcaViewModelWeak: self)
        self.demoData = cellulesContainer.demoData
    }
    
    
    
    
    
    
    //*******************************************************************************************************
    //**
    //**                newBluetoothDataReceived
    //**
    //**                    Bluetooth Manager send a line of data
    //**
    //*******************************************************************************************************
    func newBluetoothDataReceived(_ oneLineArray: [String]) {
        var aRideData = RideDataModel()
        
        aRideData = rideDataPreparation!.crunchANewLine(oneLineArray)
        
        
        //________________________________________
        //--
        //--        1- insert in Database
        //--
        //________________________________________
        if !simulationMode {
            DatabaseManager.shared.bufferRideData(aRideData)
        }
        
        
        
        //________________________________________
        //--
        //--        2- Send Fichier Manager to be save in files
        //--
        //________________________________________
        //--        2a- RawData from Cycle Analyst
        if !simulationMode {
            if setup.allowWriteCycleAnalystRawData {
                let aDateNotime = BTCAUtility.dateForCATime(date: aRideData.date)
                var temp = oneLineArray
                temp.insert(aDateNotime, at: 0)
                fichierManager.newLineReceived(data: temp, fileType: FileType.cycleAnalystrawData)
            }
            
            //--        2b- All calculated Data
            if setup.allowWriteAllCalculatedData {
                fichierManager.newLineOfAllDataReceived(rideData: aRideData, fileType: FileType.allCalculatedData)
            }
        }
        
        
        
        //________________________________________
        //--
        //--        3- Caculad
        //--
        //________________________________________
        //        if displayCanUpdate {         // after testing -> it is not needed but maybe shuld stay there
        let rideDataStruct = RideDataStruct(rideData: aRideData)
        let arrayToDisplay = fillRideDataDisplayCell(rideDataStruct: rideDataStruct)
        
        // now how to send to display
        for newCellule in arrayToDisplay {
            if let index = demoData.firstIndex(where: { $0.id == newCellule.id }) {
                demoData[index].position = newCellule.position
                demoData[index].valueToDisplay = newCellule.valueToDisplay
                demoData[index].color = newCellule.color
                demoData[index].title = newCellule.title
                demoData[index].unit = newCellule.unit
            }
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //*******************************************************************************************************
    //**
    //**                fillRideDataDisplayCell
    //**
    //**                   Prepare Cell for display
    //**
    //*******************************************************************************************************
    
    func fillRideDataDisplayCell(rideDataStruct: RideDataStruct) -> [Cellule]{
        var lesCells: [Cellule] = []
        
        let mirror = Mirror(reflecting: rideDataStruct)
        for child in mirror.children {
            
            var BTCAType : RideDataEnum
            var id: Int = 0
            var position: Int = 0
            var title: String = ""
            var unit: String = ""
            var color: Color = .blue
            var valueToDisplay : String = ""
            
            
            if let label = child.label {
                BTCAType = BTCAConstant.whichBTCAVar(aText: label)
                id = BTCAType.intValue
                position = displayPreference.position[BTCAType]!
                title = displayPreference.title[BTCAType]!
                unit = displayPreference.unit[BTCAType]!
                
                if let aColor = displayPreference.color[BTCAType] {
                    color = aColor.color
                } else {
                    color = .red
                }
                
                switch BTCAType {
                    
                    
                //________________________________________
                //--
                //--        Date
                //________________________________________
                case   RideDataEnum.date, RideDataEnum.gpsDateTime :
                    if let value = child.value as? Date {
                        valueToDisplay = BTCAUtility.dateToString(date: value)
                        title = BTCAUtility.dateToTitle(date: value)
                    }
                    
                    
                //________________________________________
                //--
                //--        Double
                //________________________________________
                case RideDataEnum.gpsDirection, RideDataEnum.gpsElevation, RideDataEnum.gpsLatitude, RideDataEnum.gpsLongitude, RideDataEnum.gpsSpeed :
                    if let value = child.value as? Double {
                        valueToDisplay = BTCAUtility.doubleToString(value: value, btcaVar: BTCAType, displayPreference: displayPreference)
                    }
                    
                //________________________________________
                //--
                //--        String
                //________________________________________
                case RideDataEnum.flag :
                    if let value = child.value as? String {
                        let flag = limitFlagEnum.whichFlag(letter:value )
                        valueToDisplay = "\(flag.nameText)"
                        unit = value + "=\(flag.nameText)"
                    }
                    
                    
                //________________________________________
                //--
                //--        Int16
                //________________________________________
                case RideDataEnum.human :
                    if let value = child.value as? Int16 {
                        valueToDisplay = String(value)
                    }
                    
                    
                //________________________________________
                //--
                //--        Float
                //________________________________________
                default:
                    if let value = child.value as? Float {
                        valueToDisplay = BTCAUtility.floatToString(value: value, btcaVar: BTCAType, displayPreference: displayPreference)
                    }
                }
                
            } else {
                print ("error in if let label = child.label {")
            }
            
            
            lesCells.append(Cellule(id: id, position: position, valueToDisplay: valueToDisplay, color: color, title: title, unit: unit))
        }
        
        return lesCells
    }
    
    
    
    
    
    //*******************************************************************************************************
    //**
    //**                A little bit like App Intent
    //**
    //**                   Call from ViewModel Sub Class
    //**
    //*******************************************************************************************************
    
    
    
    //_______________________________________________________________________________________________________
    //--
    //--
    //-- MARK:               AcceuiltView
    //--
    //_______________________________________________________________________________________________________
    
    var isBatteryFullButtonEnable: Bool = true
    private var timerForBatteryFull: Timer?
    
    func batteryisFullNow() {
        isBatteryFullButtonEnable = false
        rideDataPreparation!.batteryIsFullNow()
        startTimerForBatteryFull()
    }
    
    
    
    private func startTimerForBatteryFull() {
        timerForBatteryFull?.invalidate()
        timerForBatteryFull = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
            self!.isBatteryFullButtonEnable = true
        }
    }
    
    
    
    
    
    
    //_______________________________________________________________________________________________________
    //--
    //--
    //-- MARK:               BluetoothManager
    //--
    //_______________________________________________________________________________________________________
    
    // View Can Read
    // BluetoothManager has one like this, that update this one
    var isSetupValidated: Bool = false
    
    // View Can Read
    // BluetoothManager has one like this, that update this one
    var isBluetoothOn: Bool = false
    
    
    // View Can Call
    func resetQoS() {
        bluetoothManager?.resetQoS()
    }
    
    // View Can read
    // BluetoothManager has one like this, that update this one
    var isBluetoothConnected = false {
        didSet {
            if isBluetoothConnected {
                simulationManager?.stopSimulation()
                simulationMode = false
                // put simluation false
                // disable simulation button
            }
        }
    }
    
    // BluetoothManger Read This
    func howManyDataWeShouldReceive() -> Int {
        return setup.firmwareVersion.numberOfDataPerFirmwareVersion()
    }
    
    
    // VIew call this
    func startScanning() {
        bluetoothManager!.startScanning()
    }
    
    // VIew call this
    func DisconnectCurrentPeripheral() {
        bluetoothManager!.stopScanning()
        bluetoothManager!.disconnectCurrentPeripheral()
        
    }
    
    
    
    
    
    
    
    
    //_______________________________________________________________________________________________________
    //--
    //-- MARK:               DisplayPreferenceEditView
    //_______________________________________________________________________________________________________
    func resetTitle() {
        displayPreference.title = displayPreference.titleDefault()
        displayPreference.save()                                            // old DisplayPreference.shared.save()
    }
    func resetUnit() {
        displayPreference.unit = displayPreference.unitDefault()
        displayPreference.save()
    }
    func resetPrecision() {
        displayPreference.precision = displayPreference.precisionDefault()
        displayPreference.save()
    }
    func resetPosition() {
        displayPreference.position = displayPreference.positionDefault()
        displayPreference.save()
    }
    func resetColor() {
        displayPreference.color = displayPreference.colorDefault()
        displayPreference.save()
    }
    
    
    
    
    //_______________________________________________________________________________________________________
    //--
    //--
    //-- MARK:               Firmware
    //--
    //_______________________________________________________________________________________________________
    
    func firmwareWasChanged() {
        rideDataPreparation!.resetRideDataPrevious()
        isAllowedToNavigateAutomatically = true
        resetPosition()
    }
    
    
    
    
    //_______________________________________________________________________________________________________
    //--
    //-- MARK:               LocationUpdate
    //_______________________________________________________________________________________________________
    
    let locationHandler: LocationHandlerProtocol = LocationHandlerFactory.makeHandler()
    
    
    func startLocationUpdateGPS() {
        if setup.isLocationDesired {
            locationHandler.startLocationUpdates()
        }
    }
    
    
    func stopLocationUpdateGPS() {
        locationHandler.stopLocationUpdates()  // it handle background location by itself
    }
    
    
    func checkBeforeStartLocationUpdateGPS() {      // for setup, if user turn on GPS after bluetooth already connected, i know bad Design :-)
        if let _ = bluetoothManager!.connectedPeripheral {
            if setup.isLocationDesired {
                locationHandler.startLocationUpdates()
            }
        }
    }
    
    
    
    //_______________________________________________________________________________________________________
    //--
    //--
    //-- MARK:               MetricOrImperial
    //--
    //_______________________________________________________________________________________________________
    
    func metricOrImperialChanged() {
        resetUnit()
    }
    
    //_______________________________________________________________________________________________________
    //--
    //--
    //-- MARK:               RideDataPreparation
    //--
    //_______________________________________________________________________________________________________
    
    func resetRideDataPrevious() {
        rideDataPreparation!.resetRideDataPrevious()
    }
    
    
    
    //_______________________________________________________________________________________________________
    //--
    //--
    //-- MARK:               simulation
    //--
    //_______________________________________________________________________________________________________
    
    var simulationButtonTimer: Timer?
    
    
    var simulationMode: Bool = false {
        didSet {
            if simulationMode && !isBluetoothConnected{ // if simulationMode = true && Bluetooth is not Connected
                buttonToGridIsEnable = false            // Start Simulation
                simulationManager!.startSimulation(firmwareType: setup.firmwareType)
                startTimerforSimulation()
                
            } else if !simulationMode {                 // if simulationMode = false
                buttonToGridIsEnable = true             // Stop Simulation
                stopTimerforSimulation()
                simulationManager!.stopSimulation()
            }
        }
    }
    
    
    func startTimerforSimulation() {        // just for the Grid Button
        simulationButtonTimer = Timer.scheduledTimer(timeInterval: 1.5, target:self, selector: #selector(reEnableButtonAndNavigateAuto), userInfo:nil,repeats: false)
        simulationButtonTimer?.tolerance = 0.2
    }
    
    
    func stopTimerforSimulation() {
        simulationButtonTimer?.invalidate()
        reEnableButtonAndNavigateAuto()
    }
    
    
    @objc func reEnableButtonAndNavigateAuto() {      // TODO: Timer not used
        buttonToGridIsEnable = true
        navigateToGridAutomatically = true
    }
    
    
    
    
}








