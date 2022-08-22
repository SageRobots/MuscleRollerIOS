//
//  ScanView.swift
//  MuscleRoller
//
//  Created by Carl Winge on 8/17/22.
//

import SwiftUI
import CoreBluetooth

struct ScanView: View {
    @EnvironmentObject var bt: BT
    @State private var scanDisabled = false
    
    var body: some View {
        VStack {
            Button(action: bt.startScanning) {
                Text("Scan")
            }
            .disabled(bt.disableScan)
            //list devices found
            List {
                ForEach(bt.peripheralArray, id: \.self) { peripheral in
                    NavigationLink(destination: Menu(preview: false)) {
                        Text(peripheral.name!)
                    }
                }
            }
        }
    }
    
}

struct ScanView_Previews: PreviewProvider {
    static let bt = BT()
    
    static var previews: some View {
        ScanView()
            .environmentObject(bt)
    }
}
