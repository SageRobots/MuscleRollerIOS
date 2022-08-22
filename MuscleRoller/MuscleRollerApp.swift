//
//  MuscleRollerApp.swift
//  MuscleRoller
//
//  Created by Carl Winge on 8/15/22.
//

import SwiftUI

@main
struct MuscleRollerApp: App {
    @StateObject var bt = BT()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScanView()
            }
            .environmentObject(bt)
        }
    }
}
