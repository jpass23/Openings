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
        NavigationStack{
            List {
                Section("Sicilian Variations") {
                    ForEach(model.openingsList.sorted(by: <), id: \.key) { key, value in
                        if value.name == "Sicilian"{
                            Button {
                                opening = value
                                showMenu = false
                            } label: {
                                Text(key).foregroundColor(.primary)
                            }
                        }
                    }
                }
                Section("Italian Game Variations") {
                    ForEach(model.openingsList.sorted(by: <), id: \.key) { key, value in
                        if value.name == "Italian Game"{
                            Button {
                                opening = value
                                showMenu = false
                            } label: {
                                Text(key).foregroundColor(.primary)
                            }
                        }
                    }
                }
                Section("Others") {
                    ForEach(model.openingsList.sorted(by: <), id: \.key) { key, value in
                        if let _ = value.variation{
                            
                        }else{
                            Button {
                                opening = value
                                showMenu = false
                            } label: {
                                Text(key).foregroundColor(.primary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Choose an opening")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// struct OpeningListView_Previews: PreviewProvider {
//    static var previews: some View {
//        OpeningListView()
//    }
// }
