//
//  Constants.swift
//  Uplift Control
//
//  Created by Jonathan Jacob on 6/7/20.
//  Copyright © 2020 Jonathan Jacob. All rights reserved.
//

import Foundation
import CoreBluetooth


struct BluetoothDeskConnectionConstants {
    // Overarching service that contains all of the Desk controls and info
    static let DESK_SERVICE_UUID = CBUUID(string: "0000ff12-0000-1000-8000-00805f9b34fb")
    // This is the uuid that does all of the heavy lifting, Moving the desk up/down, saving presets.
    static let DESK_CHARACTERISTIC_INPUT_DATA = CBUUID(string: "0000ff01-0000-1000-8000-00805f9b34fb")
    // This returns the current height of the desk
    static let DESK_CHARACTERISTIC_OUTPUT_DATA = CBUUID(string: "0000ff02-0000-1000-8000-00805f9b34fb")
    // This is the uuid to enable or disable the pair code
    static let DESK_CHARACTERISTIC_TOGGLE_PAIRING = CBUUID(string: "0000ff07-0000-1000-8000-00805f9b34fb")
    // This is the uuid to set your pair code
    static let DESK_CHARACTERISTIC_CODE_PAIRING = CBUUID(string: "0000ff05-0000-1000-8000-00805f9b34fb")
    //Unused
    
    // This is the uuid that returns the MCU firmware version
    //FW_VERSION_CHAR_UUID = UUID.fromString("0000fff2-0000-1000-8000-00805f9b34fb");

    // This is the uuid that returns the desk's custom bluetooth name
    //DEVICE_NAME_CHAR_UUID = UUID.fromString("0000ff06-0000-1000-8000-00805f9b34fb");

    // Unknown reset options, most likely one or both of them is a factory reset option
    //FACTORYSET_CHAR_UUID = UUID.fromString("0000fff0-0000-1000-8000-00805f9b34fb");
    //RESET_CHAR_UUID = UUID.fromString("0000fff1-0000-1000-8000-00805f9b34fb");

    // Dangerous UUID's
    // I never wrote anything to these uuid's because i did not see the need for changing the option
    // due to it having the chance to damage my desk. Primarily because the old official app doesn't
    // use them either. They seem primarily leftover development/manufacturing options and not for
    // the end user. Documenting them here for future reference by myself or others.

    // BLE connection timeout options
    //LINK_INTERVAL_CHAR_UUID = UUID.fromString("0000ff04-0000-1000-8000-00805f9b34fb");
    //ADV_INTERVAL_CHAR_UUID = UUID.fromString("0000ff08-0000-1000-8000-00805f9b34fb");

    // Internal Micro-processor options
    //TX_POWER_CHAR_UUID = UUID.fromString("0000ff09-0000-1000-8000-00805f9b34fb");
    //MCU_DELAY_CHAR_UUID = UUID.fromString("0000ff0a-0000-1000-8000-00805f9b34fb");
    //BAUNDRATE_CHAR_UUID = UUID.fromString("0000ff03-0000-1000-8000-00805f9b34fb");
}


struct BluetoothDeskActionConstants{
    static let MOVE_UP = "f1f10100017e"
    static let MOVE_DOWN = "f1f10200027e"
    static let STOP = "f1f12b002b7e"
    static let SAVE_PRESET_1 = "f1f10300037e"
    static let SAVE_PRESET_2 = "f1f10400047e"
    static let GO_TO_PRESET_1 = "f1f10500057e"
    static let GO_TO_PRESET_2 = "f1f10600067e"
    static let GET_DESK_HEIGHT = "f1f10700077e"
}
