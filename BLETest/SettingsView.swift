//
//  SettingsView.swift
//  BLETest
//
//  Created by Jonathan Jacob on 6/7/20.
//  Copyright © 2020 JonnyFive. All rights reserved.
//

import SwiftUI
import CoreBluetooth

struct SettingsView: View {
    @State var showingDeskPicker = false
    @EnvironmentObject var bluetoothManager: BLEManager
    var body: some View {
        List {
            Section(header: Text("Desks")){
                Button(action: {
                    self.showingDeskPicker.toggle()
                }){
                    Text("Connect")
                }.sheet(isPresented: $showingDeskPicker){
                    BluetoothDeviceSelection(isPresented: self.$showingDeskPicker, peripheralList: self.bluetoothManager.detectedPeripherals)
                        .environmentObject(self.bluetoothManager)
                }
            }
        }
    .listStyle(GroupedListStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
