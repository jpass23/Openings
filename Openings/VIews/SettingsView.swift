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
    var body: some View {
        Form {
            Section("Appearence") {
                ColorPicker("Dark Square Color", selection: $model.darkSquareColor)
            }
            Section("Danger Zone") {
                Button("Clear All Data", role: .destructive) {
                    model.clearData()
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
