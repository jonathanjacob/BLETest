//
//  HomeView.swift
//  BLETest
//
//  Created by Jonathan Jacob on 6/7/20.
//  Copyright © 2020 JonnyFive. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
            }.tag(0)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
