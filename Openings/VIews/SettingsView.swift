//
//  SettingsView.swift
//  Openings
//
//  Created by Jaden Passero on 2/17/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var model: Model
    var body: some View {
        Form {
            Section("Aesthetics") {
                ColorPicker("Select a color", selection: $model.darkSquareColor)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
