//
//  ContentView.swift
//  MuscleRoller
//
//  Created by Carl Winge on 8/15/22.
//

import SwiftUI

struct MotorXView: View {
    @EnvironmentObject var bt: BT
    @State private var cmdPos = "123"
    @State private var cmdSpeed = "12"
    
    var body: some View {
        HStack(alignment: .top) {
        VStack(alignment: .leading) {
            List {
                HStack {
                    Text("Homed")
                    if(bt.motorX.homed) {
                        Label("Homed", systemImage: "checkmark.square.fill")
                            .labelStyle(.iconOnly)
                            .foregroundColor(Color(.systemGreen))
                    } else {
                        Label("Homed", systemImage: "clear.fill")
                            .labelStyle(.iconOnly)
                            .foregroundColor(Color(.systemGray))
                    }
                    Button(action: {
                        bt.write(type: "xhom", value: "1")
                    }) {
                        Text("Home")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                HStack {
                    Text("Home Sensor")
                    if(bt.motorX.home) {
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
                    Text(String(bt.motorX.position))
                }
                HStack {
                    Text("Target: ")
                    Text(String(bt.motorX.target))
                }
                HStack {
                    Text("Set Target:")
                    TextField("123", text: $cmdPos)
                        .keyboardType(.decimalPad)
                        .frame(minWidth: 40, idealWidth: 50, maxWidth: 60)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        bt.write(type: "xpos", value: cmdPos)
                    }) {
                        Text("Set")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                HStack {
                    Text("Speed: ")
                    Text(String(bt.motorX.speed))
                }
                HStack {
                    Text("Set Speed:")
                    TextField("12", text: $cmdSpeed)
                        .keyboardType(.decimalPad)
                        .frame(minWidth: 40, idealWidth: 50, maxWidth: 60)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        bt.write(type: "xspd", value: cmdSpeed)
                    }) {
                        Text("Set")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
        }
        .font(.title2)
        }
        .navigationTitle("Motor X")
    }
}

struct MotorXView_Previews: PreviewProvider {
    static let bt = BT()
    
    static var previews: some View {
        MotorXView()
            .environmentObject(bt)
    }
}
