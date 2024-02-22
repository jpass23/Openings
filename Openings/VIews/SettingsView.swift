//
//  SettingsView.swift
//  Openings
//
//  Created by Jaden Passero on 2/17/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var model: Model
    @State var showSheet = false
    @State var showConfirmation = false
    @State var delayTime = "0.8"
    var body: some View {
        Form {
            Section("Appearence") {
                ColorPicker("Dark Square Color", selection: $model.darkSquareColor)
                Button("Reset to default"){
                    model.darkSquareColor = Color.deepGreen
                }.foregroundStyle(.blue)
            }
            Section("Audio") {
                Toggle("Sounds", isOn: $model.sounds)
            }
            Section("Feel") {
                Toggle("Haptics", isOn: $model.haptics)
            }
            Section {
                let str = String(round(model.cpuDelay*10)/10)
                let roundedStr = str[...str.index(str.startIndex, offsetBy: 2)]
                Stepper("Response Time:  \(String(roundedStr))s", onIncrement: {
                    model.cpuDelay += 0.1
                }, onDecrement: {
                    if model.cpuDelay > 0.1{
                        model.cpuDelay -= 0.1
                    }
                })
            } header: {
                Text("Other")
            } footer: {
                Text("How much time the cpu waits before playing you back in Practice mode")
            }
            Section("Danger Zone") {
                Button("Clear All Data", role: .destructive) {
                    showConfirmation.toggle()
                }.confirmationDialog("Are you sure", isPresented: $showConfirmation) {
                    Button("Yes, clear data", role: .destructive) { model.clearData()}
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("This action cannot be undone")
                }
            }
        }
        .onDisappear(perform: {
            model.updateUserDefaults()
        })
        Text("Found a mistake? Have a suggestion?")
        HStack {
            Text("Contact developer")
            Button {
                showSheet.toggle()
            } label: {
                Text("here").padding(-5)
                    .foregroundStyle(.blue)
            }
        }.font(.caption)
            .sheet(isPresented: $showSheet) {
                ContactView()
            }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
