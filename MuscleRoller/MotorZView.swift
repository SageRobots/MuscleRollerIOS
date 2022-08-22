//
//  ContentView.swift
//  MuscleRoller
//
//  Created by Carl Winge on 8/15/22.
//

import SwiftUI

struct MotorZView: View {
    @EnvironmentObject var bt: BT
    @State private var cmdPos = "123"
    @State private var cmdSpeed = "12"
    @State private var cmdForce = "10"
    
    var body: some View {
        HStack(alignment: .top) {
        VStack(alignment: .leading) {
            List {
                HStack {
                    Text("Homed")
                    if(bt.motorZ.homed) {
                        Label("Homed", systemImage: "checkmark.square.fill")
                            .labelStyle(.iconOnly)
                            .foregroundColor(Color(.systemGreen))
                    } else {
                        Label("Homed", systemImage: "clear.fill")
                            .labelStyle(.iconOnly)
                            .foregroundColor(Color(.systemGray))
                    }
                    Button(action: {
                        bt.write(type: "zhom", value: "1")
                    }) {
                        Text("Home")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                HStack {
                    Text("Home Sensor")
                    if(bt.motorZ.home) {
                        Label("Home", systemImage: "checkmark.square.fill")
                            .labelStyle(.iconOnly)
                            .foregroundColor(Color(.systemGreen))
                    } else {
                        Label("Home", systemImage: "clear.fill")
                            .labelStyle(.iconOnly)
                            .foregroundColor(Color(.systemGray))
                    }
                }
                HStack {
                    Text("Position: ")
                    Text(String(bt.motorZ.position))
                }
                HStack {
                    Text("Target: ")
                    Text(String(bt.motorZ.target))
                }
                HStack {
                    Text("Set Target:")
                    TextField("123", text: $cmdPos)
                        .keyboardType(.decimalPad)
                        .frame(minWidth: 40, idealWidth: 50, maxWidth: 60)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        bt.write(type: "zpos", value: cmdPos)
                    }) {
                        Text("Set")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                HStack {
                    Text("Speed: ")
                    Text(String(bt.motorZ.speed))
                }
                HStack {
                    Text("Set Speed:")
                    TextField("12", text: $cmdSpeed)
                        .keyboardType(.decimalPad)
                        .frame(minWidth: 40, idealWidth: 50, maxWidth: 60)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        bt.write(type: "zspd", value: cmdSpeed)
                    }) {
                        Text("Set")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                HStack {
                    Text("Force: ")
                    Text(String(bt.motorZ.force))
                }
                HStack {
                    Text("Target: ")
                    Text(String(bt.motorZ.targetForce))
                }
                HStack {
                    Text("Set Force:")
                    TextField("12", text: $cmdForce)
                        .keyboardType(.decimalPad)
                        .frame(minWidth: 40, idealWidth: 50, maxWidth: 60)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        bt.write(type: "zfrc", value: cmdForce)
                    }) {
                        Text("Set")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
        }
        .font(.title2)
        }
        .navigationTitle("Motor Z")
    }
}

struct MotorZView_Previews: PreviewProvider {
    static let bt = BT()
    
    static var previews: some View {
        MotorZView()
            .environmentObject(bt)
    }
}
