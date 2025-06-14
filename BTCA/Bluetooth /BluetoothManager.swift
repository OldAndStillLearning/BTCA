//
//  BlueToothManager.swift
//  BtFromScratch
//
//  Created by call151 on 2024-10-29.
//

import Combine
import CoreBluetooth
import Swift

@Observable
class BluetoothManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    weak var btcaViewModelWeak: BTCAViewModel?
    
    var connectedPeripheral: CBPeripheral?              // MARK: Exposed Var
    var bluetoothStatus = BluetoothConstant.Status_Disconnected   // MARK: Exposed var
    // Disconnected - Connecting - Connected - Display in BluetoothStatusView in Text

    private var textReceived: String = ""
    private var centralManager: CBCentralManager!        // Should it be optional
    private var peripheralsDiscovered = [CBPeripheral]()
    private var deviceValidated: Bool = false
    private var txCharacteristic : CBCharacteristic?
    private var rxCharacteristic : CBCharacteristic?
    
    private var scanningTimer: AnyCancellable?          // Timer
    private(set) var secondsRemaining = 15              // Timer
    
    private var isBluetoothOn = false {
        didSet {
            btcaViewModelWeak?.isBluetoothOn = isBluetoothOn
        }
    }
    
    private var isBluetoothConnected: Bool = false {    // in BluetoothButtonView to disable Disconnect Button
        didSet {
            btcaViewModelWeak?.isBluetoothConnected = isBluetoothConnected
        }
    }
    
    private var isSetupValidated:Bool = false {
        didSet {
            btcaViewModelWeak?.isSetupValidated = isSetupValidated
        }
    }

    private var showUARTDeviceOnly = true {         // User might want to change it to see if bluetoth device without UART appear - Not implemented anymore
        didSet {                            // could be usefull for those who wnat to developt uart emitter
            let tempScanning = isScanning
            stopScanning()
            peripheralsDiscovered = [CBPeripheral]()
            if tempScanning {
                startScanning()
            }
        }
    }
    
    
    
    
    
    //_______________________________________________________________________________________________________
    //--
    //--
    //--                Class Func
    //--
    //_______________________________________________________________________________________________________
    init(btcaViewModelWeak: BTCAViewModel) {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: nil, options: nil)
        self.btcaViewModelWeak = btcaViewModelWeak
    }
    
    
    private func scanBLEWithOption (_ withUARTService: Bool){
        if withUARTService {
            print(" ask centralmanager to scan for UART")
            centralManager.scanForPeripherals(withServices: [ BluetoothConstant.BLEService_UUID], options: [CBCentralManagerScanOptionAllowDuplicatesKey:false] )              // search for bluetooth device that support UART service
        } else {
            centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey:false] )  // search for Any bluetooth device
        }
    }
    
    
    func disconnectCurrentPeripheral() {        //MARK: Exposed var
        if let peripheral = connectedPeripheral {
            centralManager.cancelPeripheralConnection(peripheral)
            
            // i know it is done twice but reading appledocumentation  on cancelPeripheralConnection(_:)
            // from apple ->   This method is nonblocking, and any CBPeripheral class commands that are still pending to peripheral may not complete. Because other apps may still have a connection to the peripheral, canceling a local connection doesn’t guarantee that the underlying physical link is immediately disconnected. From the app’s perspective, however, the peripheral is effectively disconnected, and the central manager object calls the centralManager(_:didDisconnectPeripheral:error:) method of its delegate object.
            
            connectedPeripheral = nil
            resetQoS()
        }
    }
    
    
    private func decideIfWeConnectNow(id: UUID) -> Bool {
        // we take only device that are allow to connect - mostly for me because i have many bluetooth emitter in testing
        return btcaViewModelWeak!.bluetoothDeviceManager.devices.first(where: { $0.id == id })?.isAllowedToConnect ?? true
    }
    
    
    func checkBeforeScanning(){
        if (!isScanning && !isBluetoothConnected) {
            startScanning()
        }
    }
    
    
    //_______________________________________________________________________________________________________
    //--
    //--
    //--                CBCentralManagerDelegate
    //--
    //_______________________________________________________________________________________________________
    // MARK: - CBCentralManagerDelegate
    
    
    
    //_______________________________________________________________________________________________________
    //--
    //--                CBCentralManager DID UPDATE STATE
    //_______________________________________________________________________________________________________
    //MARK: Did Update State
    internal func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        // (from Apple) In your application, you would address each possible value of central.state and central.authorization
        // (from Apple)   central.authorization
        // in https://developer.apple.com/documentation/corebluetooth/cbmanager
        // and https://developer.apple.com/documentation/corebluetooth/cbmanagerstate
        // CBManagerState
        
        switch (central.state) {
        case .poweredOff:
            print("CBCentralManager - Case poweredOff")
            isScanning = false
            isBluetoothOn = false
            stopScanning()
            
        case .poweredOn:
            print("CBCentralManager - Case poweredOn")
            isBluetoothOn = true
            checkBeforeScanning()
            
        case .unknown:
            print("CBCentralManager - Case unknown")
            
        case .resetting:
            print("CBCentralManager - Case resetting")
            
        case .unsupported:
            print("CBCentralManager - Case unsupported")
            
        case .unauthorized:
            print("CBCentralManager - Case unauthorized")
            
        default:
            print("Humm a new one ? ")
        }
        
    }
    
    
    
    
    //_______________________________________________________________________________________________________
    //--
    //--                CBCentralManager DID DISCOVER PERIPHERAL
    //_______________________________________________________________________________________________________
    //MARK: Did Discover Periphral
    internal func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber){
        
        print ("found a peripheral")
        if !peripheralsDiscovered.contains(peripheral) {
            peripheralsDiscovered.append(peripheral)
        }
        
        let name = peripheral.name ?? "Unknown" + BTCAUtility.addToName()
        let id = peripheral.identifier
        if let btcaViewModelWeak {
            btcaViewModelWeak.bluetoothDeviceManager.addOrUpdateDevice(id: id, name: name)
        } else { print("BTCA - acceuilVMWeak is nil") }
        
        
        if decideIfWeConnectNow(id: id) {
            centralManager.connect(peripheral, options: nil)
        }
    }
    
    
    //_______________________________________________________________________________________________________
    //--
    //--                CBCentralManager DID CONNECT
    //_______________________________________________________________________________________________________
    //MARK: Did Connect
    internal func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices([BluetoothConstant.BLEService_UUID])
        bluetoothStatus = BluetoothConstant.Status_Connected
        isBluetoothConnected = true
        stopScanning()
        connectedPeripheral = peripheral
        
        if let btcaViewModelWeak {
            btcaViewModelWeak.buttonToGridIsEnable = true
        } else { print("BTCA - btcaViewModelWeak is nil") }
        
        resetQoS()
        
        if btcaViewModelWeak!.setup.isLocationDesired {
            btcaViewModelWeak!.startLocationUpdateGPS()     // will start only if user enable gps in setup //TODO: what happen is user change After connected, so this is at the wrong place.
        }
    }
    
    
    
    //_______________________________________________________________________________________________________
    //
    //MARK:              CBCentralManager  DID FAIL TO CONNECT
    //_______________________________________________________________________________________________________
    //MARK: Did Fail To Connect
    internal func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: (any Error)?) {
        bluetoothStatus = BluetoothConstant.Status_Disconnected
        isBluetoothConnected = false
        connectedPeripheral = nil
        resetQoS()
        if error != nil {
            print("Error while trying to connect failed")
            return
        }
    }
    
    
    
    //_______________________________________________________________________________________________________
    //--
    //--                CBCentralManager  DID DISCONNECTED PERIPHERAL
    //_______________________________________________________________________________________________________
    //MARK: Did Disconnected Peripheral
    internal func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: (any Error)?) {
        
        bluetoothStatus = BluetoothConstant.Status_Disconnected
        isBluetoothConnected = false
        connectedPeripheral = nil
        resetQoS()
        isSetupValidated = false
        btcaViewModelWeak!.isAllowedToNavigateAutomatically =  true
        btcaViewModelWeak!.resetRideDataPrevious()
        
        if let btcaViewModelWeak {
            btcaViewModelWeak.buttonToGridIsEnable = false
        } else { print("BTCA - btcaViewModelWeak is nil") }
        
        btcaViewModelWeak!.stopLocationUpdateGPS()
    }
    
    
    
    
    
    
    //_______________________________________________________________________________________________________
    //--
    //--
    //--                CBPeripheralDelegate
    //--
    //--_____________________________________________________________________________________________________
    // MARK: - CBPeripheralDelegate
    
    
    
    //_______________________________________________________________________________________________________
    //--
    //--                PERIPHERAL  DID DISCOVER SERVICES
    //--_____________________________________________________________________________________________________
    //    MARK: Did Discover Services
    internal func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: (any Error)? ) {
        
        if ((error) != nil) { return }
        
        if let lesServices = peripheral.services {
            for aService in lesServices {
                let aServiceUUID = aService.uuid
                
                if aServiceUUID == BluetoothConstant.BLEService_UUID {
                    peripheral.discoverCharacteristics([BluetoothConstant.BLE_Characteristic_uuid_Tx,BluetoothConstant.BLE_Characteristic_uuid_Rx], for: aService)
                } else {
                    peripheral.discoverCharacteristics(nil, for: aService)
                }
            }
        } else {
            return
        }
    }
    
    
    //_______________________________________________________________________________________________________
    //--
    //--                PERIPHERAL  DID DISCOVER CHARACTERISTICS FOR
    //_______________________________________________________________________________________________________
    //MARK: Did Discover Characteristics For
    internal func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: (any Error)?) {
        
        if let allCharacteristics = service.characteristics {
            
            for oneCharacteristique in allCharacteristics {
                
                if oneCharacteristique.uuid.isEqual(BluetoothConstant.BLE_Characteristic_uuid_Rx) {
                    rxCharacteristic = oneCharacteristique
                    
                    peripheral.setNotifyValue(true, for: rxCharacteristic!)
                    peripheral.readValue(for: oneCharacteristique)                  // probably not really needed that
                }
                
                if oneCharacteristique.uuid.isEqual(BluetoothConstant.BLE_Characteristic_uuid_Tx) {
                    txCharacteristic = oneCharacteristique
                    peripheral.setNotifyValue(true, for: txCharacteristic!)         // for later to send command to Cycle Analyst or more probably to bluefeather
                }
            }
        } else {
            return
        }
        
    }
    
    
    
    
    //_______________________________________________________________________________________________________
    //--
    //--                PERIPHERAL  DID UPDATE VALUE FOR
    //_______________________________________________________________________________________________________
    //MARK: Did Update Value For
    internal func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: (any Error)?) {
        if characteristic == rxCharacteristic {
            if let  characteristic2 =  characteristic.value {
                if let myString = String(data: characteristic2, encoding: .utf8) {
                    peripheralSendUsNewData(stringReceived: myString )       //                    isReceiving = true
                }
            }
        }
    }
    
    
    //_______________________________________________________________________________________________________
    //--
    //--                PERIPHERAL  DID READ RSSI
    //_______________________________________________________________________________________________________
    //MARK: didReadRSSI
    // not used anymore
    //    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: (any Error)?) {
    //        theRSSI = RSSI
    //    }
    
    
    
    
    // next 3 used before to send Reset to Arduino and other command but are now not working in my BlueFeather
    
    //_______________________________________________________________________________________________________
    //--
    //--                PERIPHERAL  DID UPDATE VALUE FOR
    //_______________________________________________________________________________________________________
    //MARK: Did Update Value For
    //    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
    //        guard error == nil else {
    //            print("Error discovering services: error")
    //            return
    //        }
    //        print("Message sent")
    //    }
    
    //_______________________________________________________________________________________________________
    //--
    //--                For later to send command to bluetooth receiver like Reset like before
    //_______________________________________________________________________________________________________
    //MARK: writeValue
    // Write functions
    //    func writeValue(data: String){
    //        let valueString = (data as NSString).data(using: String.Encoding.utf8.rawValue)
    //        //change the "data" to valueString
    //        if let blePeripheral = connectedPeripheral {
    //            if let txCharacteristic = txCharacteristic {
    //                blePeripheral.writeValue(valueString!, for: txCharacteristic, type: CBCharacteristicWriteType.withResponse)
    //            }
    //        }
    //    }
    
    
    //_______________________________________________________________________________________________________
    //--
    //--                For later to send command to bluetooth receiver like Reset like before
    //_______________________________________________________________________________________________________
    //MARK: writeCharacteristic
    //    func writeCharacteristic(val: Int8){
    //        var val = val
    //        let ns = NSData(bytes: &val, length: MemoryLayout<Int8>.size)
    //        connectedPeripheral!.writeValue(ns as Data, for: txCharacteristic!, type: CBCharacteristicWriteType.withResponse)
    //    }
    
    
    
    
    
    
    
    //_______________________________________________________________________________________________________
    //--
    //--
    //--                TEXT Reader
    //--
    //_______________________________________________________________________________________________________
    // MARK: - Text Reader
    
    
    
    //_______________________________________________________________________________________________________
    //--
    //MARK:             PERIPHERAL SENT US NEW DATA
    //_______________________________________________________________________________________________________
    
    private func peripheralSendUsNewData (stringReceived: String)  {
        textReceived.append(stringReceived)
        
        // check is there is a \r otherwise nothing to do this time around
        if let myEndIndex = self.textReceived.firstIndex(of: BTCAConstant.eolUnicodeString) {
            
            let oneLineOfDataSubString = self.textReceived.prefix(through: myEndIndex)
            var oneLineOfData = String(oneLineOfDataSubString)
            oneLineOfData.removeLast()      // remove \r from the line of data
            let arrayOfDataReceived = oneLineOfData.components(separatedBy: "\t")
            
            let myStartIndex = self.textReceived.startIndex
            self.textReceived.removeSubrange(myStartIndex...myEndIndex)
            
            let numberOfDataWeShouldReceive: Int = btcaViewModelWeak!.howManyDataWeShouldReceive()
            
            if (arrayOfDataReceived.count == numberOfDataWeShouldReceive) {
                btcaViewModelWeak!.newBluetoothDataReceived(arrayOfDataReceived)
            }
            
            calculateCommunicationStatistique(goodData: (arrayOfDataReceived.count == numberOfDataWeShouldReceive))
        }
    }
    
    //_______________________________________________________________________________________________________
    //--
    //MARK:             QUALITY OF SERVICE
    //_______________________________________________________________________________________________________
    
    // Quality of Service
    
    private let DATA_RECEIVED_NUMBER_OF_LINE_TO_KEEP_IN_HISTORY   = 30
    private  let DATA_RECEIVED_NUMBER_OF_LINE_PERCENTAGE_GOOD_MIN  = 70.1
    
    private var dataReceivedNumberOfLine = 0
    private var dataReceivedNumberOfLineGood = 0
    
    
    var dataReceivedNumberOfLinePercentGood = 0.0  // MARK: Exposed var
    
    private var QoSBool = [Bool]()
    
    
    func resetQoS(){            //MARK: Exposed func
        QoSBool = [Bool]()
        isSetupValidated = false
        dataReceivedNumberOfLine = 0
        dataReceivedNumberOfLineGood = 0
        dataReceivedNumberOfLinePercentGood = 0.0
        self.textReceived = ""
    }
    
    
    private func calculateCommunicationStatistique(goodData: Bool){
        
        if QoSBool.count == DATA_RECEIVED_NUMBER_OF_LINE_TO_KEEP_IN_HISTORY{
            QoSBool.removeLast()
        }
        QoSBool.insert(goodData, at: 0)
        
        dataReceivedNumberOfLine = QoSBool.count
        let temp  = QoSBool.filter({$0 == true})
        dataReceivedNumberOfLineGood = temp.count
        dataReceivedNumberOfLinePercentGood =  Double(dataReceivedNumberOfLineGood) / Double(dataReceivedNumberOfLine ) * 100
        
        if dataReceivedNumberOfLinePercentGood > DATA_RECEIVED_NUMBER_OF_LINE_PERCENTAGE_GOOD_MIN {
            isSetupValidated = true
        } else {
            isSetupValidated = false
        }
    }
    
    
    
    
    //_______________________________________________________________________________________________________
    //--
    //MARK:             Scanning
    //_______________________________________________________________________________________________________
    var isScanning = false       //MARK: Exposed Var
    // in RadioWaveView for pulsating wave and to disable scanning button in BluetoothButtonView
    
    
    func startScanning(){           //MARK: Exposed Func
        disconnectCurrentPeripheral()          // before starting, cut current connection
        
        peripheralsDiscovered = [CBPeripheral]()
        bluetoothStatus = BluetoothConstant.Status_Disconnected // Not necessary
        
        if centralManager.state == .poweredOn {
            isScanning = true
            scanBLEWithOption(showUARTDeviceOnly)
            startScanningTimer()
        }
    }
    
    
    func stopScanning(){        //MARK: Exposed Var
        isScanning = false
        
        centralManager.stopScan()
        stopScanningTimer()
    }
    
    private func startScanningTimer() {
        
        guard scanningTimer == nil else { return }
        
        stopScanningTimer()
        
        secondsRemaining = 15
        scanningTimer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if self.secondsRemaining > 0 {
                    self.secondsRemaining -= 1
                    print ("secondsRemaining \(secondsRemaining)")
                } else {
                    stopScanning()
                }
            }
    }
    
    
    private func stopScanningTimer() {
        scanningTimer?.cancel()
        scanningTimer = nil
    }
    
    
}



