//
//  BluetoothDeviceSelection.swift
//  BLETest
//
//  Created by Jonathan Jacob on 6/7/20.
//  Copyright © 2020 JonnyFive. All rights reserved.
//

import SwiftUI
import CoreBluetooth

struct BluetoothDeviceSelection: View {
    @EnvironmentObject var bluetoothManager: BLEManager
    @Binding var isPresented: Bool
    @State var peripheralList: [CBPeripheral] = []
    var body: some View {
        NavigationView {
            List(bluetoothManager.detectedPeripherals, id: \.identifier) { peripheral in
                PeripheralRow(peripheral: peripheral)
                    .onTapGesture {
                        print("Row Tapped")
                        self.bluetoothManager.connectToPeripheral(peripheral: peripheral)
                        self.isPresented.toggle()
                }
            }
        .navigationBarTitle("Bluetooth Devices")
            .navigationBarItems(trailing: Button(action: {
                self.isPresented.toggle()
            }){Text("Done")})
        }
        .onAppear(){
            self.bluetoothManager.startScanning()
        }
        .onDisappear() {
            self.bluetoothManager.stopScanning()
        }
    }
}

struct BluetoothDeviceSelection_Previews: PreviewProvider {
    static var previews: some View {
        BluetoothDeviceSelection(isPresented: .constant(true))
    }
}
