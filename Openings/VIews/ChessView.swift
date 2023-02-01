//
//  ChessView.swift
//  Openings
//
//  Created by Jaden Passero on 1/25/23.
//

import SwiftUI

struct ChessView: View {
    //@EnvironmentObject var model: Model
    @State var playingBlack = false
    @State var openingName: String?
    @State var showMenu = false
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("I play...")
                HStack{
                    Spacer()
                    Text("White")
                    Toggle(isOn: $playingBlack){}.tint(.black)
                    Text("Black")
                    Spacer()
                }
                BoardView(playingBlack: $playingBlack)
                Spacer()
            }.navigationTitle(openingName ?? "No Opening")
            .toolbar{
                ToolbarItem{
                    Button{
                        showMenu.toggle()
                    }label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
            }.sheet(isPresented: $showMenu) {} content: {
                OpeningListView(openingName: $openingName, showMenu: $showMenu)
            }
        }
    }
}

struct ChessView_Previews: PreviewProvider {
    static var previews: some View {
        ChessView()
    }
}
