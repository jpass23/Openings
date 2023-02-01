//
//  OpeningListView.swift
//  Openings
//
//  Created by Jaden Passero on 2/1/23.
//

import SwiftUI

struct OpeningListView: View {
    @EnvironmentObject var model: Model
    @Binding var openingName: String?
    @Binding var showMenu: Bool
    
    var body: some View {
        List {
            ForEach(model.openingsList, id: \.self){ opening in
                Section("Sicilian Variations") {
                    if opening.contains("Sicilian"){
                        Button{
                            openingName = opening
                            showMenu = false
                        }label: {
                            Text(opening).foregroundColor(.primary)
                        }
                    }
                }
            }
        }
    }
}

//struct OpeningListView_Previews: PreviewProvider {
//    static var previews: some View {
//        OpeningListView()
//    }
//}
