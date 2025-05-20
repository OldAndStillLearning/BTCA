//
//  SimulationManager.swift
//  SetupEnvironmentManagerNoSetup
//
//  Created by call151 on 2025-04-15.
//

import Combine
import Foundation

// TODO: simulate only solar for now
class SimulationManager {
    private var simulationTimer: AnyCancellable?
    
    
//    private var uneArray2 = "2.8833\t12.40\t0.07\t17.18\t0.0000\t0.0\t0.0\t0\t0.0\t0.00\t0.99\t0.00\t-1.1996\t-0.01\t1".components(separatedBy: "\t")
    private var uneArray  = "2.8833\t48.14\t3.109\t17.4\t124.5333\t55.0\t77.2\t6\t3.3\t3.7\t0.99\t3.444\t23.73\t2.1\t1".components(separatedBy: "\t")
    
//    var passe1: Bool = false
    weak var btcaViewModelWeak: BTCAViewModel?
    
    
    init(btcaViewModelWeak: BTCAViewModel) {
        self.btcaViewModelWeak = btcaViewModelWeak
    }
    
    func startSimulation(firmwareType: FirmwareType) {
 
        uneArray = firmwareType.simulationData()
        
        stopSimulation()
        
        simulationTimer = Timer
            .publish(every: 1.0, tolerance: 0.2, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.performSimulationStep()
            }
        btcaViewModelWeak!.startLocationUpdateGPS()
    }
    
    func stopSimulation() {
        simulationTimer?.cancel()
        simulationTimer = nil
        btcaViewModelWeak!.buttonToGridIsEnable = true
        btcaViewModelWeak!.stopLocationUpdateGPS()

    }
    
    
    private func performSimulationStep() {

        btcaViewModelWeak?.newBluetoothDataReceived(uneArray)

        
        
//
//        //TODO: get data from FirmwareType func
//        
//
//        uneArray[0] = ("2.8833")        //Pos  0 - > BTCAVar.consumptionAH       Float
//        uneArray[1] = ("48.14")         //Pos  1 - > BTCAVar.batteryVolt         Float
//        uneArray[2] = ("3.109")         //Pos  2 - > BTCAVar.consumptionA        Float
//        uneArray[3] = ("17.4")          //Pos  3 - > BTCAVar.speed               Float
//        uneArray[4] = ("124.5333")      //Pos  4 - > BTCAVar.distance            Float
//        uneArray[5] = ("55.0")          //Pos  5 - > BTCAVar.tMotor              Float
//        uneArray[6] = ("77.2")          //Pos  6 - > BTCAVar.rpm                 Float
//        uneArray[7] = ("6")             //Pos  7 - > BTCAVar.human               Int
//        uneArray[8] = ("3.3")           //Pos  8 - > BTCAVar.pasTorque           Float
//        uneArray[9] = ("3.7")           //Pos  9 - > BTCAVar.throttleIN          Float
//        uneArray[10] = ("0.99")         //Pos 10 - > BTCAVar.throttleOut        Float
//        uneArray[11] = ("3.444")        //Pos 11 - > BTCAVar.auxD               Float
//        uneArray[12] = ("23.73")        //Pos 12 - > BTCAVar.solarProductionAH  Float
//        uneArray[13] = ("2.1")          //Pos 13 - > BTCAVar.solarProductionA   Float
//        uneArray[14] = ("1")            //Pos 14 - > BTCAVar.flag               Int
//        
      
    }
}


