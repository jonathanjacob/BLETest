//
//  BLEManager.swift
//  BLETest
//
//  Created by Jonathan Jacob on 6/7/20.
//  Copyright © 2020 JonnyFive. All rights reserved.
//

import Foundation
import CoreBluetooth


struct Peripheral: Identifiable {
    let id: Int
    let name: String
    let rssi: Int
}

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var myCentral: CBCentralManager!
    var deskHeightCharacteristic: CBCharacteristic!
    
    @Published var deskPeripheral: CBPeripheral! = nil
    
    @Published var isSwitchedOn = false
    @Published var isScanning = false
    @Published var isConnected = false
    @Published var peripherals = [Peripheral]()
    @Published var currentDeskHeight = "0"
    
    override init() {
        super.init()
        
        myCentral = CBCentralManager(delegate: self, queue: nil)
        myCentral.delegate = self
    }
    
    func startScanning() {
        print("StartScanning")
        peripherals.removeAll()
        myCentral.scanForPeripherals(withServices: [BluetoothDeskConnectionConstants.DESK_SERVICE_UUID], options: nil)
        self.isScanning = true
        print(BluetoothDeskConnectionConstants.DESK_CHARACTERISTIC_OUTPUT_DATA)
    }
    
    func stopScanning() {
        //print("StopScanning")
        myCentral.stopScan()
        self.isScanning = false
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            isSwitchedOn = true
        }else {
            isSwitchedOn = false
            isScanning = false
            peripherals.removeAll()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        var peripheralName: String!
        
        //peripheral.identifier.uuidString
        
        if let name = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            peripheralName = name
        }else {
            peripheralName = "Unknown"
        }
        
        let newPeripheral = Peripheral(id: peripherals.count, name: peripheralName, rssi: RSSI.intValue)
        print(newPeripheral)
        peripherals.append(newPeripheral)
        
        
        //Move this logic but for now
        
        if peripheralName == "Jonathan_Desk" {
            self.deskPeripheral = peripheral
            self.deskPeripheral.delegate = self
            self.myCentral.connect(self.deskPeripheral, options: nil)
            self.isConnected = true
        }
        
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to \(self.deskPeripheral.name ?? "no name")")
        self.deskPeripheral.discoverServices(nil)
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = deskPeripheral.services else { return }
        
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        
        for characteristic in characteristics {
            //print("UUID: \(BluetoothDeskConnectionConstants.DESK_CHARACTERISTIC_OUTPUT_DATA.uuidString)")
            //dump(characteristic)
            //print(characteristic.uuid.uuidString)
            
            //if characteristic.uuid.uuidString == BluetoothDeskConnectionConstants.DESK_CHARACTERISTIC_OUTPUT_DATA.uuidString {
                self.deskHeightCharacteristic = characteristic
                deskPeripheral.readValue(for: self.deskHeightCharacteristic)
                deskPeripheral.setNotifyValue(true, for: characteristic)
                stopScanning()
            //}
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        //dump(characteristic)
        //if characteristic.uuid.uuidString == BluetoothDeskConnectionConstants.DESK_CHARACTERISTIC_OUTPUT_DATA.uuidString {
        
        
        switch characteristic.uuid {
        case BluetoothDeskConnectionConstants.DESK_CHARACTERISTIC_OUTPUT_DATA:
            print("handled characteristic uuid \(characteristic.uuid)")
        default:
            print("unhandled characteristic uuid \(characteristic.uuid)")
            print(characteristic.value ?? "no value")
        }
            
            if let messageData = characteristic.value {
                if let dataStr = String(data: messageData, encoding: .utf8) {
                    dump(dataStr)
                    //currentDeskHeight = dataStr
                }
            }
        //}
    }
    
}
