//
//  ContentView.swift
//  BLETest
//
//  Created by Jonathan Jacob on 6/7/20.
//  Copyright © 2020 JonnyFive. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var bleManager = BLEManager()
    
    var body: some View {
        VStack (spacing: 10) {
            Text("Bluetooth Devices")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .center)
            List(bleManager.peripherals) { peripheral in
                HStack {
                    Text(peripheral.name)
                    Spacer()
                    Text(String(peripheral.rssi))
                }
            }.frame(height: 300)
            
            Spacer()
            
            if bleManager.isSwitchedOn {
                Text("Bluetooth is Switched on")
                    .foregroundColor(.green)
            }else {
                Text("Bluetooth is NOT Switched on")
                    .foregroundColor(.red)
            }
            
            if bleManager.isScanning {
                Text("Scanning")
            }else {
                Text("NOT Scanning")
            }
            
            if bleManager.isConnected {
                Text("Connected to \(bleManager.deskPeripheral.name ?? "No Name")")
            }else {
                Text("NOT Connected")
            }
            
            Text("Desk Height: \(bleManager.currentDeskHeight)")
            
            Spacer()
            
            HStack {
                VStack (spacing: 10) {
                    Button(action: {
                        self.bleManager.startScanning()
                    }){
                        Text("Start Scanning")
                    }
                    Button(action: {
                        self.bleManager.stopScanning()
                    }){
                        Text("Stop Scanning")
                    }
                }.padding()
                
                Spacer()
                
                VStack (spacing: 10){
                    Button(action: {
                        print("Start Advertising")
                    }){
                        Text("Start Advertising")
                    }
                    Button(action: {
                        print("Stop Advertising")
                    }){
                        Text("Stop Advertising")
                    }
                }.padding()
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
