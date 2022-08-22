//
//  Menu.swift
//  MuscleRoller
//
//  Created by Carl Winge on 8/16/22.
//

import SwiftUI

struct Menu: View {
    @EnvironmentObject var bt: BT
    let preview: Bool
    
    var body: some View {
        VStack {
            NavigationLink(destination: CycleView()) {
                HStack {
                    Text("Cycle")
                    Spacer()
                    Label("Cycle", systemImage: "chevron.forward")
                        .labelStyle(.iconOnly)
                }
            }
            .padding()
            
            NavigationLink(destination: MotorXView()) {
                HStack {
                    Text("Motor X")
                    Spacer()
                    Label("Motor X", systemImage: "chevron.forward")
                        .labelStyle(.iconOnly)
                }
            }
            .padding()
            
            NavigationLink(destination: MotorZView()) {
                HStack {
                    Text("Motor Z")
                    Spacer()
                    Label("Motor Z", systemImage: "chevron.forward")
                        .labelStyle(.iconOnly)
                }
            }
            .padding()
            Spacer()
        }
        .navigationTitle("Menu")
        .onAppear {
            if !preview {
                bt.connectToDevice()
            }
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static let bt = BT()
    
    static var previews: some View {
        Menu(preview: true)
            .environmentObject(bt)
    }
}
