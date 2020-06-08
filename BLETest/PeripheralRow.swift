//
//  PeripheralRow.swift
//  BLETest
//
//  Created by Jonathan Jacob on 6/7/20.
//  Copyright © 2020 JonnyFive. All rights reserved.
//

import SwiftUI
import CoreBluetooth

struct PeripheralRow: View {
    var peripheral: CBPeripheral
    
    var body: some View {
        HStack {
            Text("\(peripheral.name ?? "Unnamed")")
            Spacer()
                if peripheral.state == .connected {
                Text("Connected")
                .font(.subheadline)
                .foregroundColor(.gray)
                }else {
                    Text("Not Connected")
                        .font(.subheadline)
                        .foregroundColor(.gray)
            }
        }
    }
}
