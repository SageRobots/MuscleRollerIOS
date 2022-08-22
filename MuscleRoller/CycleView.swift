//
//  ContentView.swift
//  MuscleRoller
//
//  Created by Carl Winge on 8/15/22.
//

import SwiftUI

struct CycleView: View {
    @EnvironmentObject var bt: BT
    @State private var cmdStartX = "50"
    @State private var cmdEndX = "100"
    @State private var cmdStartZ = "50"
    @State private var cmdForce = "5"
    @State private var cmdSpeed = "5"
    @State private var cmdTravelSpeed = "30"
    
    var body: some View {
        HStack(alignment: .top) {
        VStack(alignment: .leading) {
            List {
                HStack {
                    Text("Start X:")
                    TextField("50", text: $cmdStartX)
                        .keyboardType(.decimalPad)
                        .frame(minWidth: 40, idealWidth: 50, maxWidth: 60)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack {
                    Text("End X:")
                    TextField("100", text: $cmdEndX)
                        .keyboardType(.decimalPad)
                        .frame(minWidth: 40, idealWidth: 50, maxWidth: 60)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack {
                    Text("Start Z:")
                    TextField("50", text: $cmdStartZ)
                        .keyboardType(.decimalPad)
                        .frame(minWidth: 40, idealWidth: 50, maxWidth: 60)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack {
                    Text("Force:")
                    TextField("5", text: $cmdForce)
                        .keyboardType(.decimalPad)
                        .frame(minWidth: 40, idealWidth: 50, maxWidth: 60)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack {
                    Text("Travel Speed:")
                    TextField("30", text: $cmdTravelSpeed)
                        .keyboardType(.decimalPad)
                        .frame(minWidth: 40, idealWidth: 50, maxWidth: 60)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack {
                    Text("Speed:")
                    TextField("5", text: $cmdSpeed)
                        .keyboardType(.decimalPad)
                        .frame(minWidth: 40, idealWidth: 50, maxWidth: 60)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack {
                    Button(action: {
                        bt.cycle(startX: cmdStartX, endX: cmdEndX, startZ: cmdStartZ, force: cmdForce, travelSpeed: cmdTravelSpeed, speed: cmdSpeed)
                    }) {
                        Text("Run")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    Spacer()
                    Button(action: {
                        bt.write(type: "stop", value: "1")
                    }) {
                        Text("Stop")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
        }
        .font(.title2)
        }
        .navigationTitle("Cycle")
    }
}

struct CycleView_Previews: PreviewProvider {
    static let bt = BT()
    
    static var previews: some View {
        CycleView()
            .environmentObject(bt)
    }
}
