//
//  OpeningListView.swift
//  Openings
//
//  Created by Jaden Passero on 2/1/23.
//

import SwiftUI

struct OpeningListView: View {
    @EnvironmentObject var model: Model
    @Binding var opening: Opening?
    @Binding var showMenu: Bool

    var body: some View {
        List {
            ForEach(model.openingsList.sorted(by: <), id: \.key) { key, value in
                // Section("Sicilian Variations") {
                Button {
                    opening = value
                    showMenu = false
                } label: {
                    Text(key).foregroundColor(.primary)
                }
                // }
            }
        }
    }
}

// struct OpeningListView_Previews: PreviewProvider {
//    static var previews: some View {
//        OpeningListView()
//    }
// }
