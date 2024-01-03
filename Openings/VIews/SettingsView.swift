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
